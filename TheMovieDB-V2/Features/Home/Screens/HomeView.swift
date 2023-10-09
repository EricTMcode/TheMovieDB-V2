//
//  HomeView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.moviePath) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    BackdropCarouselView(movies: vm.nowPlaying)
                    PosterCarouselView<Movie>(title: "Movie of the day", content: vm.nowPlaying)
                    PosterCarouselView<Movie>(title: "Recently Added", content: vm.upcoming)
                    PosterCarouselView<Movie>(title: "Top Rated Movie", content: vm.topRated)
                }
            }
            .refreshable {
                Task {
                    await vm.populateMovies()
                }
            }
            .padding(.vertical)
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
            .alert("Application Error", isPresented: $vm.hasError, presenting: vm.error) { _ in
                Button("Retry") {
                    Task {
                        await vm.populateMovies()
                    }
                }
            } message: { error in
                Text(error.errorDescription ?? "Try again later")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            await vm.populateMovies()
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: "SettingsView") {
                        Image(systemName: "gear")
                            .foregroundStyle(.orange)
                    }
                }
            }
            .navigationDestination(for: Movie.self) { movie in
                DetailView(id: movie.id)
            }
            .navigationDestination(for: [Movie].self) { movies in
                GridView(title: "Movies", movies: movies)
            }
            .navigationDestination(for: MovieCast.self) { cast in
                PersonView(id: cast.id)
            }
            .navigationDestination(for: String.self) { i in
                SettingsView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Favorite())
            .environmentObject(Router())
    }
}
