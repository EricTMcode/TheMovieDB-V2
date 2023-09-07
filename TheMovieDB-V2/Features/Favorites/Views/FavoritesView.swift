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
        VStack {
            if !vm.favoriteMovies.isEmpty {
                NavigationStack {
                VStack {
                    List {
                        ForEach(filteredMovies) { movie in
                            NavigationLink(value: movie) {
                                PosterCard(movie: movie, orientationType: .horizontal)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
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
            } else {
                FavoritesEmptyView()
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

private extension FavoritesView {
    
    var sortButton: some View {
        Button {
            vm.isShowingSortOptions.toggle()
        } label: {
            Label("Sort", systemImage: "arrow.up.arrow.down")
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
