//
//  Node+OID.swift
//  PostgreSQL
//
//  Created by Andrew Hulsizer on 5/13/17.
//
//

import Foundation

extension Node {
    init?(type: OID, value: String) {
        switch type {
        case .char, .name, .text, .json, .xml, .bpchar, .varchar:
            self = .string(value)
        case .int2, .int4, .int8:
            guard let int = Int(value) else {
                return nil
            }
            self = .int(int)
        case .float4, .float8:
            guard let float = Float(value) else {
                return nil
            }
            self = .float(float)
        case .bool:
            guard let bool = Bool(value) else {
                return nil
            }
            self = .bool(bool)
        case .numeric:
            guard let double = Double(value) else {
                return nil
            }
            self = .double(double)
        default:
            return nil
        }
    }
}
