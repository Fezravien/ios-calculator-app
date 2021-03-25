//
//  CalCulator.swift
//  Calculator
//
//  Created by 이영우 on 2021/03/22.
//
import Foundation

class Calculator {
    var preOperation = ""
    var numberString = ""
    var stack = Stack<String>()
    
    func input(value: String) {
        if Int(value) != nil {
            numberString += value
        } else if value == "=" {
            operateFinalStatus()
            exit(0)
        } else {
            if stack.isEmpty == true {
                initStack(value)
            } else {
                decidePriorityForOperation(value)
            }
        }
    }

    func operateMiddleStatus(first: String, operation: String, second: String) -> Float {
        guard let first = Float(first), let second = Float(second) else {
            return 0.0
        }
        switch operation {
        case "+":
            return first + second
        case "-":
            return first - second
        case "*":
            return first * second
        case "/":
            return first / second
        default:
            fatalError()
        }
    }

    func operateFinalStatus() {
        if stack.count < 3 {
            let operation = stack.pop()!
            let first = stack.pop()!
            let result = operateMiddleStatus(first: first, operation: operation, second: numberString)
            print(String(result).prefix(9))
        } else {
            let a = operateMiddleStatus(first: stack.pop()!, operation: preOperation, second: numberString)
            let operation = stack.pop()!
            let first = stack.pop()!
            let result = operateMiddleStatus(first: first, operation: operation, second: String(a))
            print(String(result).prefix(9))
        }
    }

    func initStack(_ value: String) {
        if numberString.count != 0 {
            stack.push(numberString)
            stack.push(value)
            preOperation = value
            numberString = ""
        }
    }

    func decidePriorityForOperation(_ value: String) {
        if value == "+" || value == "-" {
            hasPriorityLow(value)
        } else if value == "*" || value == "/" {
            hasPriorityHigh(value)
        }
    }

    private func hasPriorityLow(_ value: String) {
        guard let inputPriority = OperatorType(rawValue: value)?.priority,
              let preInputPriority = OperatorType(rawValue: preOperation)?.priority else {
            
            return
        }
        if inputPriority < preInputPriority {
            hasPriorityHighToLow(value)
            return
        }
        let operation = stack.pop()!
        let first = stack.pop()!
        let result = operateMiddleStatus(first: first, operation: operation, second: numberString)
        print(result)
        stack.push(String(result))
        stack.push(value)
        preOperation = value
        numberString = ""
    }

    private func hasPriorityHigh(_ value: String) {
        guard let inputPriority = OperatorType(rawValue: value)?.priority,
              let preInputPriority = OperatorType(rawValue: preOperation)?.priority else {
            
            return
        }
        if inputPriority > preInputPriority {
            hasPriorityLowToHigh(value)
        } else {
            stack.push(numberString)
            preOperation = value
            numberString = ""
        }
    }

    private func hasPriorityHighToLow(_ value: String) {
        if stack.count < 3 {
            let operation = stack.pop()!
            let first = stack.pop()!
            let result = operateMiddleStatus(first: first, operation: operation, second: numberString)
            print(result)
            stack.push(String(result))
            stack.push(value)
            numberString = ""
            return
        }
        let first = stack.pop()!
        let result = operateMiddleStatus(first: first, operation: preOperation, second: numberString)
        let operation = stack.pop()!
        let initValue = stack.pop()!
        let finalResult = operateMiddleStatus(first: initValue, operation: operation, second: String(result))
        numberString = ""
        stack.push(String(finalResult))
        stack.push(value)
        preOperation = value
        print(finalResult)
    }

    private func hasPriorityLowToHigh(_ value: String) {
        if stack.count < 3 {
            let operation = stack.pop()!
            let first = stack.pop()!
            let result = operateMiddleStatus(first: first, operation: operation, second: numberString)
            print(result)
            stack.push(String(result))
            stack.push(preOperation)
            numberString = ""
            return
        }
        let first = stack.pop()!
        let result = operateMiddleStatus(first: first, operation: value, second: numberString)
        print(result)
        stack.push(String(result))
        numberString = ""
    }

}
