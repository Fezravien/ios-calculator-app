//
//  Stack.swift
//  Calculator
//
//  Created by 이영우 on 2021/03/22.
//

import Foundation

public struct Stack<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public mutating func reset() {
        array.removeAll()
    }
    
    public var top: T? {
        return array.last
    }
}
