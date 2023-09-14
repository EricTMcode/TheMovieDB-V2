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
    
    func resetMoviePath() {
        moviePath = NavigationPath()
    }
    
    func resetFavoritesPath() {
        favoritesPath = NavigationPath()
    }
}
