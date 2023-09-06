//
//  TheMovieDB_V2App.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import SwiftUI

@main
struct TheMovieDB_V2App: App {
    @StateObject var favorites = FavoriteViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorites)
        }
    }
}
