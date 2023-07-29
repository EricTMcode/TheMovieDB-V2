//
//  Bundle+Extension.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/07/2023.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(filename: String) -> T {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate \(filename) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from the bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let decodedModel = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(filename) from the bundle.")
        }
        
        return decodedModel
    }
}

extension Movie {
    static var localMovies: [Movie] {
        let response: MovieResponse = Bundle.main.decode(filename: "movie_list")
        return response.results
    }
    
    static var localMovie: Movie {
        localMovies[0]
    }
}
