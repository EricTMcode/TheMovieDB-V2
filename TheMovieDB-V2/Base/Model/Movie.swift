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
    let voteCount: Int
    let runtime: Int?
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let recommendations: MovieRecommendationsResponse?
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
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
    
    var durationText: String {
        guard let runtime = runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var yearText: String {
        guard let releaseDate = releaseDate, let date = Movie.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var recommendationsVideo: [Movie]? {
        return (recommendations?.results.isEmpty)! ? nil : recommendations?.results
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

struct MovieRecommendationsResponse: Codable, Hashable {
    let results: [Movie]
}
