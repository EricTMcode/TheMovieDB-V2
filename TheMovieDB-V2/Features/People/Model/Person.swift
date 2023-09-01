//
//  Person.swift
//  TheMovieDB-V2
//
//  Created by Eric on 01/09/2023.
//

import Foundation

struct Person: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let biography: String?
    let profilePath: String?
    let placeOfBirth: String?
    let birthday: String?
    let knownForDepartment: String?
    let movieCredits: MoviePersonCredit?
    
    var profileURL: URL {
        URL(string: "\(Constants.imgUrl)\(profilePath ?? "")")!
    }
    
    var backdropURL: URL {
        URL(string: "\(Constants.imgOriginalUrl)\(movieCast?.first?.backdropPath ?? "")")!
    }
    
    var movieCast: [Movie]? {
        movieCredits?.cast
    }
    
    var biographyText: String {
        guard let biography = biography, biography.count > 0 else {
            return "n/a"
        }
        return biography
    }

}

struct MoviePersonCredit: Codable, Hashable {
    let cast: [Movie]
}
