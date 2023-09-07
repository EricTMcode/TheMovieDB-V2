//
//  FavoritesEmptyView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 07/09/2023.
//

import SwiftUI

struct FavoritesEmptyView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "film")
                .font(.system(size: 48))
            Text("No Favorite Movies")
            Text("You can add movie by pressing the star on the movie*")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct FavoritesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesEmptyView()
    }
}
