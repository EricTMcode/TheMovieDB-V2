//
//  ContentView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var favorite: Favorite
    @EnvironmentObject var router: Router
    
    @State private var tabSelected = 0
    @State private var tappedTwice = false
    
    var handler: Binding<Int> { Binding(
        get: { tabSelected },
        set: {
            if $0 == tabSelected {
                tappedTwice = true
            }
            tabSelected = $0
        }
    )}
    
    var body: some View {
        TabView(selection: handler) {
            HomeView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
                .onChange(of: tappedTwice) { tappedTwice in
                    guard tappedTwice else { return }
                    if tabSelected == 0 {
                        self.tappedTwice = false
                        router.resetAllMoviePath()
                    }
                }
                .tag(0)
            TVView()
                .tabItem {
                    Label("TV Show", systemImage: "sparkles.tv")
                }
                .tag(1)
            FavoriteView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .onChange(of: tappedTwice) { tappedTwice in
                    guard tappedTwice else { return }
                    if tabSelected == 2 {
                        self.tappedTwice = false
                        router.resetAllFavoritePath()
                    }
                }
                .tag(2)
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .onChange(of: tappedTwice) { tappedTwice in
                    guard tappedTwice else { return }
                    if tabSelected == 3 {
                        self.tappedTwice = false
                        router.resetAllSearchPath()
                    }
                }
                .tag(3)
        }
        .onAppear {
            // Correct the transparency for Tab bars
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Favorite())
            .environmentObject(Router())
    }
}
