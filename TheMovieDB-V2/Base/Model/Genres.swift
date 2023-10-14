//
//  Genres.swift
//  TheMovieDB-V2
//
//  Created by Eric on 14/10/2023.
//

import Foundation

struct Genres: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
}
