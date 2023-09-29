//
//  TheMovieDB_V2App.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import SwiftUI

@main
struct TheMovieDB_V2App: App {
    @StateObject var favorite = Favorite()
    @StateObject var router = Router()
    @AppStorage("interfaceTheme") private var interfaceTheme: InterfaceTheme = .auto
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorite)
                .environmentObject(router)
                .preferredColorScheme(interfaceTheme == .light ? .light : interfaceTheme == .dark ? .dark : nil)
        }
    }
}
