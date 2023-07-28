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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    BackdropCarouselView(movies: vm.nowPlaying)
                    PosterCarouselView(title: "Movie of the day", movies: vm.nowPlaying)
                    PosterCarouselView(title: "Recently Added", movies: vm.upcoming)
                    PosterCarouselView(title: "Top Rated Movie", movies: vm.topRated)
                }
                .padding([.top, .bottom])
                .navigationTitle("Welcome")
                .task {
                    if !vm.hasAppeared {
                        await vm.populateMovies()
                        vm.hasAppeared = true
                    }
                }
                .overlay {
                    if vm.isLoading {
                        ProgressView()
                    }
                }
                .alert(isPresented: $vm.hasError, error: vm.error) {
                    Button("Retry") {
                        Task {
                            await vm.populateMovies()
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            Task {
                                await vm.populateMovies()
                            }
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.orange)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "gear")
                            .foregroundColor(.orange)
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
