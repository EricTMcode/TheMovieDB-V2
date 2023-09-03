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
    let biography: String
    let profilePath: String?
    let placeOfBirth: String?
    let birthday: String?
    let knownForDepartment: String?
    let movieCredits: MoviePersonCredit?
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    var profileURL: URL {
        URL(string: "\(Constants.imgUrl)\(profilePath ?? "")")!
    }
    
    var backdropURL: URL {
        URL(string: "\(Constants.imgOriginalUrl)\(movieCast?.first?.backdropPath ?? "")")!
    }
    
    var movieCast: [Movie]? {
        movieCredits?.cast.sorted(by: { $0.voteCount > $1.voteCount })
    }
    
    var biographyText: String {
        let errorText = "We don't have a biography."
        return biography.isEmpty ? errorText : biography
    }
    
    var placeOfBirthText: String {
        guard let placeOfBirth = placeOfBirth else {
            return "n/a"
        }
        return placeOfBirth
    }
    
    var knownForDepartmentText: String {
        guard let knownForDepartment = knownForDepartment else {
            return "n/a"
        }
        return knownForDepartment
    }
    
    var birthdayText: String {
        guard let birthday = birthday, let date = Person.dateFormatter.date(from: birthday) else {
            return "n/a"
        }
        return Person.yearFormatter.string(from: date)
    }
}

struct MoviePersonCredit: Codable, Hashable {
    let cast: [Movie]
}
