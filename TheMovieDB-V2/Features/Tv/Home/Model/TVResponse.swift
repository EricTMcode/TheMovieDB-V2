//
//  TVResponse.swift
//  TheMovieDB-V2
//
//  Created by Eric on 08/10/2023.
//

import Foundation

struct TVResponse: Codable {
    let results: [Tv]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
