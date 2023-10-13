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
    let genres: [TVGenre]?
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
    
    var cast: [Cast]? {
        credits?.cast
    }
}

struct TVGenre: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
}

//struct TVCredit: Codable, Hashable {
//    let cast: [TVCast]
//}
//
//struct TVCast: Codable, Hashable, Identifiable {
//    let id: Int
//    let character: String
//    let name: String
//    let profilePath: String?
//    
//    var profileURL: URL {
//        return URL(string: "\(Constants.imgUrl)\(profilePath ?? "")")!
//    }
//}
