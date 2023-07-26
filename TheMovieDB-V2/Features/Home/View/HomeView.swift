//
//  HomeView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                ForEach(vm.nowPlaying) { movie in
                    Text(movie.title)
                }
            }
            .navigationTitle("Movies")
            .task {
                await vm.fetchMovies()
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchMovies()
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
