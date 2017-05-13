//
//  Result.swift
//  PostgreSQL
//
//  Created by Andrew Hulsizer on 5/4/17.
//
//

import Foundation
import libpq

public final class Result {
    public typealias Row = [String: Node]
    
    let result: OpaquePointer
    public let rows: [Row]
    
    public init?(result: OpaquePointer?) throws {
        switch PQresultStatus(result) {
        case PGRES_TUPLES_OK:
            self.result = result!
        case PGRES_COMMAND_OK:
            return nil
        default:
            let message = PQresultErrorMessage(result)!
            throw PostgresError(message: String(cString: message))
        }
        
        var rows = [Row]()
        for rowIndex in 0..<PQntuples(result) {
            
            var row = Row()
            for columnIndex in 0..<PQnfields(result) {
                let type = PQftype(result, columnIndex)
                let value = String(cString: PQgetvalue(result, rowIndex, columnIndex)!)
                let name = String(cString: PQfname(result, columnIndex)!)
                
                if let oid =  OID(rawValue: Oid(type)),
                   let node = Node(type: oid, value: value) {
                    row[name] = node
                }
            }
            
            rows.append(row)
        }
        
        self.rows = rows
    }
    
    public var rowCount: Int32 {
        return PQntuples(result)
    }
    
    public var columnCount: Int32 {
        return PQnfields(result)
    }
    
//    public subscript(row row: Int, column column: Int) -> Node? {
//        guard row < rows.count else {
//            return nil
//        }
//        let resultRow = rows[row]
//        let values = resultRow.values
//        
//        guard column < values.count else {
//            return nil
//        }
//        
//        return values[column]
//    }
    
    deinit {
        PQclear(result)
    }
    
}
