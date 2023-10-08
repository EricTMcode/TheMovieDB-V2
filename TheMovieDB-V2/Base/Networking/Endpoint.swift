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
    case person(id: Int)
    case search(query: String)
    case tvPopular(page: Int)
}

extension Endpoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
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
        case .person(let id):
            return "/3/person/\(id)"
        case .search:
            return "/3/search/movie"
        case .tvPopular :
            return "/3/tv/popular"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .nowPlaying, .upcoming, .topRated, .detail, .person, .search, .tvPopular:
            return .GET
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .nowPlaying(let page):
            return ["page": "\(page)"]
        case .upcoming(let page):
            return ["page": "\(page)"]
        case .topRated(let page):
            return ["page": "\(page)"]
        case .detail:
            return ["append_to_response": "videos,credits,recommendations"]
        case .person:
            return ["append_to_response": "movie_credits"]
        case .search(let query):
            return ["query": query]
        case .tvPopular(let page):
            return ["page": "\(page)"]
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        let staticQueryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey),
                                URLQueryItem(name: "language", value: Constants.language)]
        
        let requestQueryItems = queryItems.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
        urlComponents.queryItems = staticQueryItems + requestQueryItems
        
        return urlComponents.url
    }
}
