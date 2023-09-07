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
                    ForEach(vm.filteredMovies) { movie in
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
        Button("Name (A-Z)") { vm.sortOption = .name }
        Button("Date (Newest first)") { vm.sortOption = .date }
    }
}
