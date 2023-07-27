//
//  APIService.swift
//  TheMovieDB-V2
//
//  Created by Eric on 27/07/2023.
//

import Foundation

struct APIService {
    
    func request<T: Codable>(_ endpooint: Endpoint, type: T.Type?) async throws -> T {
        guard let url = endpooint.url else {
            throw NetworkingError.invalidUrl
        }
        
        print(url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}

extension APIService {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
        case custom(error: Error)
    }
}

extension APIService.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}
