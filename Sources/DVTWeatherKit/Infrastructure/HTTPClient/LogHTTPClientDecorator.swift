//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

public struct LogHTTPClientDecorator: HTTPClient {
    public let httpClient: HTTPClient
    
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    public func data(_ request: HTTPRequest) async throws -> HTTPResponse {
        let methodName = String(describing: request.method).uppercased()
        let requestSignature = "\(methodName) \(request.path)"
        debugPrint("🔵 Started \(requestSignature) 🔵")
        
        do {
            let response = try await httpClient.data(request)
            
            debugPrint("🟢 Success \(requestSignature) 🟢", response, String(data: response.body, encoding: .utf8) as Any)
            return response
        } catch {
            debugPrint("🔴 Failed \(requestSignature) 🔴", error)
            throw error
        }
        
    }
}

extension HTTPClient {
    public func addLog() -> HTTPClient {
        LogHTTPClientDecorator(httpClient: self)
    }
}
