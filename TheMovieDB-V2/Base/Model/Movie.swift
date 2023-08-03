//
//  Movie.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import Foundation

struct Movie: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let runtime: Int?
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    
    var posterURL: URL {
        return URL(string: "\(Constants.imgUrl)\(posterPath ?? "")")!
    }
    
    var backdropURL: URL {
        return URL(string: "\(Constants.imgUrl)\(backdropPath ?? "")")!
    }
    
    var backdropOriginalURL: URL {
        return URL(string: "\(Constants.imgOriginalUrl)\(backdropPath ?? "")")!
    }
    
    var genreText: String {
        guard let genres = genres else {
            return "n/a"
        }
        return genres.prefix(3).map { $0.name }.joined(separator: ", ")
    }
}

struct MovieGenre: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
}

struct MovieCredit: Codable, Hashable {
    let cast: [MovieCast]
}

struct MovieCast: Codable, Hashable, Identifiable {
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
    
    var profileURL: URL {
        return URL(string: "\(Constants.imgUrl)\(profilePath ?? "")")!
    }
}
