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
    
    enum CodingKeys: String, CodingKey {
        case id, overview, posterPath, voteAverage, backdropPath, genres, credits
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
}
