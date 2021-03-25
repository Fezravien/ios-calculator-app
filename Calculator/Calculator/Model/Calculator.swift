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
                output()
            }
        } else {
            postfix.append(numberInput)
            numberInput = Constant.blank
            popHigherPrioritythan(input)
            pushOperatorInStack(input)
        }
    }
    
    func output() {
        let postfixFirst = postfix.removeFirst()
        
        if !operatorArray.contains(postfixFirst) {
            stack.push(postfixFirst)
            return
        }
        
        guard let stackFirst = stack.pop() else { return }
        guard let numberFirst = Double(stackFirst) else { return }
        guard let stackSecond = stack.pop() else { return }
        guard let numberSecond = Double(stackSecond) else { return }
        
        if postfixFirst == "-" {
            let result = numberSecond - numberFirst
            stack.push(String(result))
        } else if postfixFirst == "+" {
            let result = numberSecond + numberFirst
            stack.push(String(result))
        } else if postfixFirst == "*" {
            let result = numberSecond * numberFirst
            stack.push(String(result))
        } else if postfixFirst == "/" {
            let result = numberSecond / numberFirst
            stack.push(String(result))
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
    
    func popHigherPrioritythan(_ input: String) {
        guard let inputPriority = OperatorType(rawValue: input)?.priority else {
            return
        }
        
        outer: for _ in Constant.zero..<stack.count {
            guard let stackTop = stack.top else {
                return
            }
            guard let stackTopOperatorType = OperatorType(rawValue: stackTop) else {
                return
            }
            if inputPriority <= stackTopOperatorType.priority {
                guard let value = stack.pop() else {
                    return
                }
                postfix.append(value)
            } else {
                break outer
            }
        }
    }
}
