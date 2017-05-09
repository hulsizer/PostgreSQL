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
    let result: OpaquePointer
    
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
    
    var rowCount: Int32 {
        return PQntuples(result)
    }
    
    var columnCount: Int32 {
        return PQnfields(result)
    }
    
    subscript(row row: Int32, column column: Int32) -> String {
        let type = PQftype(result, column)
        let value = PQgetvalue(result, row, column)!
        return String(cString: value) + " \(type)"
    }
    
    deinit {
        PQclear(result)
    }
    
}
