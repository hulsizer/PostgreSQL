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

public final class Database {
    
    fileprivate let name: String
    fileprivate let user: String
    fileprivate let password: String
    fileprivate let port: String
    
    public init(name: String, user: String, password: String, port: String) {
        self.name = name
        self.user = user
        self.password = password
        self.port = port
    }
    
    public func connectionString() -> String {
        return "dbname='\(name)' host='localhost' user='\(user)' password='\(password)' client_encoding='UTF8'"
    }
    
    public func connect() throws -> Connection {
        return try Connection(connectionInfo: self.connectionString())
    }
    
    public func execute(_ query: String, _ values: [Node]? = []) throws -> Result? {
        guard query.isEmpty else {
            throw DatabaseError.noQuery
        }
        
        let connection = try self.connect()
        
        return try connection.query(query)
    }
}
