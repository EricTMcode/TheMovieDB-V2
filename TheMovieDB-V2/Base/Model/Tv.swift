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
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, posterPath, voteAverage, backdropPath
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
    
    var yearText: String {
        return "2000"
    }
}
