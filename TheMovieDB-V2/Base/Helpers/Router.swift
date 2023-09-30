//
//  Router.swift
//  TheMovieDB-V2
//
//  Created by Eric on 12/09/2023.
//

import SwiftUI

class Router: ObservableObject {
    
    @Published var moviePath = NavigationPath()
    @Published var favoritesPath = NavigationPath()
    @Published var searchPath = NavigationPath()
    
    func resetMoviePath() {
        moviePath = NavigationPath()
    }
    
    func resetFavoritesPath() {
        favoritesPath = NavigationPath()
    }
    
    func resetSearchPath() {
        searchPath = NavigationPath()
    }
    
    func resetAllPath() {
        resetMoviePath()
        resetFavoritesPath()
        resetSearchPath()
    }
}
