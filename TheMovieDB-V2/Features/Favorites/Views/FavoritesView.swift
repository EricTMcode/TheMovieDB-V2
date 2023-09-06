//
//  FavoritesView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 03/08/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var vm: FavoriteViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(vm.favoriteMovies) { movie in
                    Text(movie.title)
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoriteViewModel())
    }
}
