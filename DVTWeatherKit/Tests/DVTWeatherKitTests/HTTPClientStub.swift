//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation
import DVTWeatherKit

class HTTPClientStub: HTTPClient {
    struct Stub {
        let data: Data
    }
    
    static let anyStatus = 999
    private var stubs: [HTTPRequest: Stub] = [:]
    
    // Allows you to set up a predefined response for a specific path
    func stub(for key: HTTPRequest, response data: Data) {
        stubs[key] = Stub(data: data)
    }
    
    func data(_ request: HTTPRequest) async throws -> HTTPResponse {
        guard let stub = stubs[request] else {
            throw InvalidRequestError(path: request.path)
        }
        return HTTPResponse(body: stub.data, status: Self.anyStatus)
    }
    
    struct InvalidRequestError: Error {
        let path: HTTPRequest.Path
    }
}
