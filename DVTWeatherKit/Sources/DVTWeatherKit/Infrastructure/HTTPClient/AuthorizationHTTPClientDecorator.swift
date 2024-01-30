//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

public struct AuthorizationHTTPClientDecorator: HTTPClient {
    public let apiKey: String
    public let httpClient: HTTPClient
    
    public init(apiKey: String, httpClient: HTTPClient) {
        self.apiKey = apiKey
        self.httpClient = httpClient
    }
    
    public func data(_ request: HTTPRequest) async throws -> HTTPResponse {
        var request = request
        var queryItems = request.queryItems ?? []
        queryItems.append(URLQueryItem(name: "appid", value: apiKey))
        request.queryItems = queryItems
        
        return try await httpClient.data(request)
    }
}


extension HTTPClient {
    public func addAuthorization(apiKey: String) -> HTTPClient {
        AuthorizationHTTPClientDecorator(apiKey: apiKey, httpClient: self)
    }
}

