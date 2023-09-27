//
//  FavoriteView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 27/09/2023.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favorite: Favorite
    @AppStorage("sortOption") private var sortOption: SortOption = .date
    
    var body: some View {
        NavigationStack {
            ZStack {
                favoriteListView
                
                if favorite.favoriteMovies.isEmpty {
                    favoriteEmptyView
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Movie.self) { movie in
                DetailView(id: movie.id)
            }
            .toolbar {
                if !favorite.favoriteMovies.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        sortButton
                    }
                }
            }
            .confirmationDialog("Sort by...", isPresented: $favorite.isShowingSortOptions) {
                confirmationButton
            }
        }
    }
}

#Preview {
    FavoriteView()
        .environmentObject(Favorite())
}

private extension FavoriteView {
    
    var favoriteListView: some View {
        VStack {
            List {
                ForEach(filteredMovies) { movie in
                    NavigationLink(value: movie) {
                        PosterCard(movie: movie, orientationType: .horizontal)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                favorite.remove(movie)
                            }
                        } label: {
                            Image(systemName: "trash" )
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    var favoriteEmptyView: some View {
        VStack(spacing: 10) {
            Image(systemName: "film")
                .font(.system(size: 48))
            Text("No Favorite Movies")
            Text("You can add movie by pressing the star on the movie*")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    var sortButton: some View {
        Button {
            favorite.isShowingSortOptions.toggle()
        } label: {
            Image(systemName: sortOption == .date ? "arrow.up.arrow.down" : "textformat.abc")
        }
    }
    
    @ViewBuilder
    var confirmationButton: some View {
        Button("Name (A-Z)") { sortOption = .name }
        Button("Date (Newest first)") { sortOption = .date }
    }
    
    var filteredMovies: [Movie] {
        switch sortOption {
        case .name:
            favorite.favoriteMovies.sorted { $0.title < $1.title }
        case .date:
            favorite.favoriteMovies.reversed()
        }
    }
}
