//
//  CalCulator.swift
//  Calculator
//
//  Created by 이영우 on 2021/03/22.
//
import Foundation

class Calculator {
    var stack: Stack = Stack()
    var postfix = [String]()
    var numberInput = Constant.blank
    let operatorArray = OperatorType.allCases.map{ $0.rawValue }
    
    func input(_ input: String) {
        if !operatorArray.contains(input) {
            numberInput = numberInput + input
        } else if input == "=" {
            postfix.append(numberInput)
            numberInput = Constant.blank
            popAllOperatorToList()
            for _ in Constant.zero..<postfix.count {
                let postfixFirst = postfix.removeFirst()
                
                if !operatorArray.contains(postfixFirst) {
                    stack.push(postfixFirst)
                    return
                }
                
                guard let stackFirst = stack.pop() else { return }
                guard let numberFirst = Double(stackFirst) else { return }
                guard let stackSecond = stack.pop() else { return }
                guard let numberSecond = Double(stackSecond) else { return }
                
                let stringValue = output(operatorString: postfixFirst, numberFirst: numberFirst, numberSecond: numberSecond)
                stack.push(stringValue)
            }
        } else {
            postfix.append(numberInput)
            numberInput = Constant.blank
            popHigherPrioritythan(input)
            
            pushOperatorInStack(input)
        }
    }
    
    func output(operatorString: String, numberFirst: Double, numberSecond: Double) -> String {
        if operatorString == "-" {
            let result = numberSecond - numberFirst
            return String(result)
        } else if operatorString == "+" {
            let result = numberSecond + numberFirst
            return String(result)
        } else if operatorString == "*" {
            let result = numberSecond * numberFirst
            return String(result)
        } else if operatorString == "/" {
            let result = numberSecond / numberFirst
            return String(result)
        } else {
            return ""
        }
    }
    
    func pushOperatorInStack(_ input: String) {
        stack.push(input)
    }
    
    func popAllOperatorToList() {
        for _ in Constant.zero..<stack.count {
            guard let stackTop = stack.pop() else {
                return
            }
            postfix.append(stackTop)
        }
    }
    
    func popHigherPrioritythan(_ input: String) { // 현재 입력된 우선순위와 스택에 이미 존재하는 가장 위의 스택이랑 비교를 하는 잡
        guard let inputPriority = OperatorType(rawValue: input)?.priority else {
            return
        }
        
        guard let stackTop = stack.top else {
            return
        }
        
        guard let stackTopOperatorType = OperatorType(rawValue: stackTop) else {
            return
        }
        
        if inputPriority <= stackTopOperatorType.priority {
            guard let numberFirst = Double(postfix.removeLast()) else { return }
            guard let number = postfix.last else { return }
            guard let numberSecond = Double(postfix.removeLast()) else { return }
            let result = output(operatorString: stackTop, numberFirst: numberSecond, numberSecond: numberFirst)
            postfix.append(result)
            stack.pop()
        } else {
            guard let value = stack.pop() else {
                return
            }
            postfix.append(value)
        }
        
    }
}
