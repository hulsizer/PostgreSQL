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
    
    public let connection: OpaquePointer
    public var isConnected: Bool {
        if PQstatus(connection) == CONNECTION_OK {
            return true
        }
        return false
    }
    
    public func getError() -> PostgresError {
        guard let errorMessage = PQerrorMessage(connection) else {
            return PostgresError(message: "General Error")
        }
        return PostgresError(message: String(cString: errorMessage))
    }
    
    init(connection: String) throws {
        self.connection = PQconnectdb(connection)
        if !isConnected {
            throw self.getError()
        }
    }
    
    deinit {
        PQclear(connection)
    }
    
    @discardableResult
    func execute(_ query: String, _ values: [Node]? = []) throws -> [[String: Node]] {
        
        guard !query.isEmpty else {
            throw PostgresError(message: "Query cannot be empty")
        }
        
        let pointer = PQexec(connection, query)!
        if let result = try Result(result: pointer) {
            return result.parse()
        }
        
        return [[:]]
        
    }
}
