//
//  MediaProtocol.swift
//  TheMovieDB-V2
//
//  Created by Eric on 13/10/2023.
//

import Foundation

protocol MediaProtocol: Identifiable, Hashable {
    var id: Int { get }
    var posterString: String { get }
    var title: String { get }
    var voteAverageText: String { get }
    var yearText: String { get }
    var backdropURL: URL { get }
    var backdropOriginalURL: URL { get }
    var overview: String { get }
    var genreText: String { get }
    var cast: [Cast]? { get }
}

