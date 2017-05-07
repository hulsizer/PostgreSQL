//
//  Result.swift
//  PostgreSQL
//
//  Created by Andrew Hulsizer on 5/4/17.
//
//

import Foundation
import libpq

final class Result {
    
    public let result: OpaquePointer
    
    init?(result: OpaquePointer?) throws {
        switch PQresultStatus(result) {
        case PGRES_TUPLES_OK:
            self.result = result!
        case PGRES_COMMAND_OK:
            return nil
        default:
            let message = PQresultErrorMessage(result)!
            throw PostgresError(message: String(cString: message))
        }
    }
    
    deinit {
        PQclear(result)
    }
    
    func parse() -> [[String : Node]] {
        
        var parsed: [[String: Node]] = []
        
        let rowCount: Int32 = PQntuples(result)
        let columnCount: Int32 = PQnfields(result)
        
        for row in 0..<rowCount {
            
            var item: [String: Node] = [:]
            
            for column in 0..<columnCount {
                let name = String(cString: PQfname(result, column)!)
                let value = PQgetvalue(result, row, column)!
                
                item[name] = Node.string(String(cString: value))
                parsed.append(item)
            }
        }
        
        return parsed
    }
}
