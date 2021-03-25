//
//  BinaryCalculator.swift
//  Calculator
//
//  Created by 이영우 on 2021/03/22.
//

import Foundation

class BinaryCalculator: Calculator {
    static let shared = BinaryCalculator()
    
    private override init() { }
    
    override func output() {
        let postfixFirst = postfix.removeFirst()
        
        if !operatorArray.contains(postfixFirst) { //숫자일 경우 stack에 넣어버리기
            stack.push(postfixFirst)
            return
        }
        
        guard let stackFirst = stack.pop() else { return }
        guard let numberFirst = Int(stackFirst, radix: 2) else { return }

        if postfixFirst == "~" {
            let result = ~numberFirst
            stack.push(String(result, radix: 2))
            return
        }
        
        guard let stackSecond = stack.pop() else { return }
        guard let numberSecond = Int(stackSecond, radix: 2) else { return }
        
        if postfixFirst == "-" {
            let result = numberSecond - numberFirst
            stack.push(String(result, radix: 2))
        } else if postfixFirst == "+" {
            let result = numberSecond + numberFirst
            stack.push(String(result, radix: 2))
        } else if postfixFirst == "&" {
            let result = numberSecond & numberFirst
            stack.push(String(result, radix: 2))
        } else if postfixFirst == "|" {
            let result = numberSecond | numberFirst
            stack.push(String(result, radix: 2))
        } else if postfixFirst == ">>" {
            let result = numberSecond >> numberFirst
            stack.push(String(result, radix: 2))
        } else if postfixFirst == "<<" {
            let result = numberSecond << numberFirst
            stack.push(String(result, radix: 2))
        } else if postfixFirst == "^" {
            let result = numberSecond ^ numberFirst
            stack.push(String(result, radix: 2))
        } else if postfixFirst == "~|" {
            let result = ~(numberSecond | numberFirst)
            stack.push(String(result, radix: 2))
        } else if postfixFirst == "~&" {
            let result = ~(numberSecond & numberFirst)
            stack.push(String(result, radix: 2))
        }
    }
}
