//
//  OperatorType.swift
//  Calculator
//
//  Created by 이영우 on 2021/03/23.
//

import Foundation

enum OperatorType: String, CaseIterable {
    case add = "+"
    case subtract = "-"
    case multiple = "*"
    case divide = "/"
    case and = "&"
    case nand = "~&"
    case or = "|"
    case nor = "~|"
    case xor = "^"
    case not = "~"
    case leftShift = "<<"
    case rightShift = ">>"
    
    func resultDecimal(operatorType: Self, lhs: Double, rhs: Double = 0) -> Double {
        switch operatorType{
        case .add:
            return lhs + rhs
        case .subtract:
            return lhs - rhs
        case .multiple:
            return lhs * rhs
        case .divide:
            return lhs / rhs
        default:
            return 0
        }
    }
    
    func resultBinary(operatorType: Self, lhs: Int, rhs: Int = 0) -> Int {
        switch operatorType {
        case .and:
            return lhs & rhs
        case .nand:
            return ~(lhs & rhs)
        case .or:
            return lhs | rhs
        case .nor:
            return ~(lhs | rhs)
        case .xor:
            return lhs ^ rhs
        case .not:
            return ~lhs
        case .leftShift:
            return lhs << rhs
        case .rightShift:
            return lhs >> rhs
        default:
            return 0
        }
    }
    
    var priority: Int {
        switch self {
        case .multiple, .divide, .not, .nand, .nor:
            return 10
        case .add, .subtract:
            return 9
        case .leftShift, .rightShift:
            return 8
        case .and:
            return 7
        case .xor:
            return 6
        case .or:
            return 5
        }
    }
    
    var symbol: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiple:
            return "*"
        case .divide:
            return "/"
        case .and:
            return "&"
        case .nand:
            return "~&"
        case .or:
            return "|"
        case .nor:
            return "~|"
        case .xor:
            return "^"
        case .not:
            return "~"
        case .leftShift:
            return "<<"
        case .rightShift:
            return ">>"
        }
    }
}
