//
//  Endpoint.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import Foundation

enum Endpoint {
    case nowPlaying(page: Int)
    case upcoming(page: Int)
    case topRated(page: Int)
    case detail(id: Int)
}

extension Endpoint {
    var host: String { "api.themoviedb.org" }
    
    var path: String {
        switch self {
        case .nowPlaying :
            return "/3/movie/now_playing"
        case .upcoming :
            return "/3/movie/upcoming"
        case .topRated :
            return "/3/movie/top_rated"
        case .detail(let id):
            return "/3/movie/\(id)"
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .nowPlaying(let page):
            return ["api_key": Constants.apiKey,
                    "language" : "en-US",
                    "page": "\(page)"]
        case .upcoming(let page):
            return ["api_key": Constants.apiKey,
                    "language" : "en-US",
                    "page": "\(page)"]
        case .topRated(let page):
            return ["api_key": Constants.apiKey,
                    "language" : "en-US",
                    "page": "\(page)"]
        case .detail:
            return ["api_key": Constants.apiKey, "append_to_response": "videos,credits,similar"]
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        let requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}