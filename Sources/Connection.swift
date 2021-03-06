//
//  Connection.swift
//  
//
//  Created by Andrew Hulsizer on 5/3/17.
//
//

import Foundation
import libpq

public struct PostgresError: Error {
    let message: String
}

public final class Connection {
    let connection: OpaquePointer
    public init(connectionInfo: String) throws {
        connection = PQconnectdb(connectionInfo)
        guard PQstatus(connection) == CONNECTION_OK else {
            throw PostgresError(message: "Connection failed")
        }
    }
    
    @discardableResult
    public func query(_ sql: String) throws -> Result? {
        let pointer = PQexec(connection, sql)!
        return try Result(result: pointer)
    }
    
    deinit {
        PQfinish(connection)
    }
}
