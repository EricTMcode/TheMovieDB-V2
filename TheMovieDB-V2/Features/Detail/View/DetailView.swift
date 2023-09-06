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
                    if favorites.contains(vm.movie!) {
                        Button {
                            favorites.remove(vm.movie!)
                        } label: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    } else {
                        Button {
                            favorites.add(vm.movie!)
                        } label: {
                            Image(systemName: "star")
                        }
                    }
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
