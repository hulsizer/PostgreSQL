//
//  Node.swift
//  PostgreSQL
//
//  Created by Andrew Hulsizer on 5/3/17.
//
//

import Foundation

enum Node {
    case int(Int)
    case string(String)
    case double(Double)
    
    var string: String? {
        switch self {
        case .string(let string):
            return string
        default:
            return nil
        }
    }
    
    var int: Int? {
        switch self {
        case .int(let int):
            return int
        default:
            return nil
        }
    }
    
    var double: Double? {
        switch self {
        case .double(let double):
            return double
        default:
            return nil
        }
    }
}
