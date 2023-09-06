//
//  FileManager+Exentsion.swift
//  TheMovieDB-V2
//
//  Created by Eric on 04/09/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths [0]
    }
}
