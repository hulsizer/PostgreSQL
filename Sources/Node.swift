//
//  Node.swift
//  PostgreSQL
//
//  Created by Andrew Hulsizer on 5/3/17.
//
//

import Foundation

public enum Node {
    case int(Int)
    case string(String)
    case double(Double)
    
    public var string: String? {
        switch self {
        case .string(let string):
            return string
        default:
            return nil
        }
    }
    
    public var int: Int? {
        switch self {
        case .int(let int):
            return int
        default:
            return nil
        }
    }
    
    public var double: Double? {
        switch self {
        case .double(let double):
            return double
        default:
            return nil
        }
    }
}
