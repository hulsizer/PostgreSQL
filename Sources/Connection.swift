//
//  Connection.swift
//  
//
//  Created by Andrew Hulsizer on 5/3/17.
//
//

import Foundation
import libpq

struct Connection {
    
    public let cConnection: OpaquePointer
    public var isConnected: Bool {
        if PQstatus(cConnection) == CONNECTION_OK {
            return true
        }
        return false
    }
    
    public var lastError: String {
        guard let errorMessage = PQerrorMessage(cConnection) else {
            return ""
        }
        return String(cString: errorMessage)
    }
    
    init(name: String, user: String, password: String, port: String) throws {
        let string = "host='localhost' port='\(port)' dbname='\(name)' user='\(user)' password='\(password)' client_encoding='UTF8'"
        self.cConnection = PQconnectdb(string)
        if !isConnected {
            throw DatabaseError.cannotEstablishConnection(lastError)
        }
    }
    
    @discardableResult
    func execute(_ query: String, _ values: [Node]? = []) throws -> [[String: Node]] {
        
        guard !query.isEmpty else {
            throw DatabaseError.noQuery
        }
        
        return []
    }
}
