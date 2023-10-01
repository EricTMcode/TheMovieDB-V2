//
//  InterfaceTheme.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/09/2023.
//

import Foundation

enum InterfaceTheme: Int, CaseIterable, Identifiable {
    case auto = 0
    case light = 1
    case dark = 2
    var id: Int { self.rawValue }
    
    var name: String {
        switch self {
        case .auto:
            return String("System")
        case .light:
            return String("Light")
        case .dark:
            return String("Dark")
        }
    }
}
