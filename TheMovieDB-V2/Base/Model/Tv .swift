//
//  Tv .swift
//  TheMovieDB-V2
//
//  Created by Eric on 08/10/2023.
//

import Foundation

struct Tv: Codable, Hashable, Identifiable, MovieProtocol {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, overview, posterPath, backdropPath, firstAirDate, voteAverage, voteCount
        case title = "name"
        
    }
    
    var posterString: String {
        return "\(Constants.imgUrl)\(posterPath ?? "")"
    }
    
    var voteAverageText: String {
        return String(format: "%.1f", voteAverage)
    }
    
    var yearText: String {
        return "2000"
    }
}