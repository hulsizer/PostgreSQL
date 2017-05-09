//
//  Connection.swift
//  
//
//  Created by Andrew Hulsizer on 5/3/17.
//
//

import Foundation
import libpq

struct PostgresError: Error {
    let message: String
}

final class Connection {
    let connection: OpaquePointer
    init(connectionInfo: String) throws {
        connection = PQconnectdb(connectionInfo)
        guard PQstatus(connection) == CONNECTION_OK else {
            throw PostgresError(message: "Connection failed")
        }
    }
    
    @discardableResult
    func query(_ sql: String) throws -> Result? {
        let pointer = PQexec(connection, sql)!
        return try Result(result: pointer)
    }
    
    deinit {
        PQfinish(connection)
    }
}
