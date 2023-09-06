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
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.favoriteMovies) { movie in
                        NavigationLink(value: movie) {
                            PosterCard(movie: movie, orientationType: .horizontal)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Movie.self) { movie in
                DetailView(id: movie.id)
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
