
//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public protocol HTTPClient {
    func data(_ request: HTTPRequest) async throws -> HTTPResponse
}

public enum HTTPMethod {
    case get, post
}

public struct HTTPRequest: Hashable {
    public typealias Path = String
    
    public var method: HTTPMethod
    public let path: Path
    public var queryItems: [URLQueryItem]?
    
    public init(
        method: HTTPMethod = .get,
        path: Path,
        queryItems: [URLQueryItem]? = nil
    ) {
        self.method = method
        self.path = path.trimmingCharacters(in: .init(charactersIn: "/"))
        self.queryItems = queryItems
    }
}

public struct HTTPResponse {
    public typealias StatusCode = Int
    public let body: Data
    public let status: StatusCode
    
    public init(
        body: Data,
        status: StatusCode
    ) {
        self.body = body
        self.status = status
    }
}
