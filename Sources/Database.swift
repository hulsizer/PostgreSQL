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
    
    func connect() -> Connection {
        return Connection()
    }
    
    func execute(_ query: String, _ values: [Node]? = []) throws -> [[String: Node]] {
        guard query.isEmpty else {
            throw DatabaseError.noQuery
        }
        
        let connection = self.connect()
        
        return try connection.execute(query, values)
    }
}
