//
//  Database.swift
//  
//
//  Created by Andrew Hulsizer on 5/3/17.
//
//

import Foundation

public enum DatabaseError: Error {
    case cannotEstablishConnection(String)
    case indexOutOfRange
    case columnNotFound
    case invalidSQL(message: String)
    case noQuery
    case noResults
}

struct Database {
    
    fileprivate let name: String
    fileprivate let user: String
    fileprivate let password: String
    fileprivate let port: String
    
    init(name: String, user: String, password: String, port: String) {
        self.name = name
        self.user = user
        self.password = password
        self.port = port
    }
    
    func connect() throws -> Connection {
        return try Connection(connection: "dbname=\(name) host=localhost user=\(user) password=\(password) port=\(port) client_encoding='UTF8'")
    }
    
    func execute(_ query: String, _ values: [Node]? = []) throws -> [[String: Node]] {
        guard query.isEmpty else {
            throw DatabaseError.noQuery
        }
        
        let connection = try self.connect()
        
        return try connection.execute(query, values)
    }
}
