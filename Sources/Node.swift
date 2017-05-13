//
//  Node.swift
//  PostgreSQL
//
//  Created by Andrew Hulsizer on 5/3/17.
//
//

import Foundation

public enum Node {
    case bool(Bool)
    case int(Int)
    case float(Float)
    case double(Double)
    case string(String)
    
    public var bool: Bool? {
        switch self {
        case .bool(let bool):
            return bool
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
    
    public var float: Float? {
        switch self {
        case .float(let float):
            return float
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
    
    public var string: String? {
        switch self {
        case .string(let string):
            return string
        default:
            return nil
        }
    }
}
