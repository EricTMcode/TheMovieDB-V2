//
//  Tv.swift
//  TheMovieDB-V2
//
//  Created by Eric on 08/10/2023.
//

import Foundation

struct Tv: Codable, Hashable, Identifiable, MediaProtocol {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let genres: [Genres]?
    let credits: Credit?
    let recommendations: TVRecommendationsResponse?
    let videos: TVVideoResponse?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, posterPath, voteAverage, backdropPath, genres, credits, videos, recommendations
        case title = "name"
        
    }
    
    var posterString: String {
        return "\(Constants.imgUrl)\(posterPath ?? "")"
    }
    
    var backdropURL: URL {
        return URL(string: "\(Constants.imgUrl)\(backdropPath ?? "")")!
    }
    
    var backdropOriginalURL: URL {
        return URL(string: "\(Constants.imgOriginalUrl)\(backdropPath ?? "")")!
    }
    
    var voteAverageText: String {
        return String(format: "%.1f", voteAverage)
    }
    
    var genreText: String {
        guard let genres = genres else {
            return "n/a"
        }
        return genres.prefix(3).map { $0.name }.joined(separator: ", ")
    }
    
    var yearText: String {
        return "2000"
    }
    
    var infoText: String {
        return "★ \(voteAverageText) - 2011 - Status: In production"
    }
    
    var cast: [Cast]? {
        credits?.cast
    }
    
    var recommendationsVideo: [Tv]? {
        return (recommendations?.results.isEmpty)! ? nil : recommendations?.results
    }
    
    var video: [TVVideo]? {
        videos?.results.filter { $0.type.lowercased() == "trailer" || $0.type.lowercased() == "official trailer" }
    }
}

struct TVRecommendationsResponse: Codable, Hashable {
    let results: [Tv]
}

struct TVVideoResponse: Codable, Hashable {
    let results: [TVVideo]
}

struct TVVideo: Codable, Identifiable, Hashable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
    let official: Bool
}
