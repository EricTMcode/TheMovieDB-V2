//
//  DetailView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/07/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm = DetailViewModel()
    @EnvironmentObject var favorites: FavoriteViewModel
    let id: Int
    
    var body: some View {
        VStack {
            if vm.movie != nil {
                MovieDetailView(movie: vm.movie!)
            }
        }
        .task {
            await vm.fetchDetails(for: id)
        }
        .overlay {
            if vm.viewState == .loading {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if vm.movie != nil {
                    favoritesButton
                }
            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Retry") {
                Task {
                    await vm.fetchDetails(for: id)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(id: Movie.localMovie.id)
                .environmentObject(FavoriteViewModel())
        }
    }
}

private extension DetailView {
    
    var favoritesButton: some View {
        Image(systemName: favorites.contains(vm.movie!) ? "star.fill" : "star")
            .foregroundColor(.yellow)
            .onTapGesture {
                favorites.toogleFav(vm.movie!)
            }
    }
}
