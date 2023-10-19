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
    @Published var tvPath = NavigationPath()
    
    func resetMoviePath() {
        if moviePath.count > 0 {
            moviePath.removeLast()
        }
    }
    
    func resetTVPath() {
        if tvPath.count > 0 {
            tvPath.removeLast()
        }
    }
    
    func resetFavoritesPath() {
        if favoritesPath.count > 0 {
            favoritesPath.removeLast()
        }
    }
    
    func resetSearchPath() {
        if searchPath.count > 0 {
            searchPath.removeLast()
        }
    }
    
    func resetAllPath() {
        resetMoviePath()
        resetTVPath()
        resetFavoritesPath()
        resetSearchPath()
    }
    
    func resetAllMoviePath() {
        moviePath = NavigationPath()
    }
    
    func resetAllTVPath() {
        tvPath = NavigationPath()
    }
    
    func resetAllFavoritePath() {
        favoritesPath = NavigationPath()
    }
    
    func resetAllSearchPath() {
        searchPath = NavigationPath()
    }
}
