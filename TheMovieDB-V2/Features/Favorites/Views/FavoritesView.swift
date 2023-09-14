//
//  FavoritesView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 03/08/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var vm: FavoriteViewModel
    @AppStorage("sortOption") private var sortOption: SortOption = .date
    
    var body: some View {
        if !vm.favoriteMovies.isEmpty {
            favoritesListView
        } else {
            favoritesEmptyView
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoriteViewModel())
    }
}

private extension FavoritesView {
    
    var favoritesListView: some View {
        NavigationStack {
            List {
                ForEach(filteredMovies) { movie in
                    NavigationLink(value: movie) {
                        PosterCard(movie: movie, orientationType: .horizontal)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                vm.remove(movie)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    sortButton
                }
            }
            .confirmationDialog("Sort by...", isPresented: $vm.isShowingSortOptions) {
                confirmationButton
            }
            .navigationDestination(for: Movie.self) { movie in
                DetailView(id: movie.id)
            }
        }
    }
    
    var favoritesEmptyView: some View {
        VStack(spacing: 10) {
            Image(systemName: "film")
                .font(.system(size: 48))
            Text("No Favorite Movies")
            Text("You can add movie by pressing the star on the movie*")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    var sortButton: some View {
        Button {
            vm.isShowingSortOptions.toggle()
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
            return vm.favoriteMovies.sorted { $0.title < $1.title }
        case .date:
            return vm.favoriteMovies.reversed()
        }
    }
}
