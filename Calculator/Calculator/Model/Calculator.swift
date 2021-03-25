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
            //            popAllOperatorToList()
            for _ in Constant.zero..<stack.count {
                guard let firstLastElement = postfix.popLast() else { return }
                guard let firstLastNumber = Double(firstLastElement) else { return }
                guard let secondLastElement = postfix.popLast() else { return }
                guard let secondLastNumber = Double(secondLastElement) else { return }
                
                guard let topOperator = stack.pop() else { return }
                
                let result = output(operatorString: topOperator, numberFirst: firstLastNumber, numberSecond: secondLastNumber)
                postfix.append(result)
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
            guard let numberSecond = Double(postfix.removeLast()) else { return }
            let result = output(operatorString: stackTop, numberFirst: numberSecond, numberSecond: numberFirst)
            postfix.append(result)
            _ = stack.pop()
        } else {
            for _ in Constant.zero..<stack.count {
                
                guard let topOperator = stack.top else { return }
                guard let ss = OperatorType(rawValue: topOperator) else {
                    return
                }
                
                if ss.priority > inputPriority {
                    _ = stack.pop()
                    
                    guard let firstLastElement = postfix.popLast() else { return }
                    guard let firstLastNumber = Double(firstLastElement) else { return }
                    guard let secondLastElement = postfix.popLast() else { return }
                    guard let secondLastNumber = Double(secondLastElement) else { return }
                    
                    
                    let result = output(operatorString: topOperator, numberFirst: firstLastNumber, numberSecond: secondLastNumber)
                    postfix.append(result)
                }
            }
        } //현재 우선순위가 stack Top의 우선순위보다 높을 때?
        
    }// 11 * 2 * 2 + 2 =
    
}
