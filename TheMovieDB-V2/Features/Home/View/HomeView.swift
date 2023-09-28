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
                    PosterCarouselView(title: "Movie of the day", movies: vm.nowPlaying)
                    PosterCarouselView(title: "Recently Added", movies: vm.upcoming)
                    PosterCarouselView(title: "Top Rated Movie", movies: vm.topRated)
                }
            }
            .refreshable {
                Task {
                    await vm.populateMovies()
                }
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
                    Image(systemName: "gear")
                        .foregroundColor(.orange)
                }
                
            }
            .navigationDestination(for: Movie.self) { movie in
                DetailView(id: movie.id)
            }
            .navigationDestination(for: [Movie].self) { movies in
                GridView(title: "Movies", movies: movies)
                //                    PosterCarouselView(title: "Movie of the day", movies: movies)
            }
            .navigationDestination(for: MovieCast.self) { cast in
                PersonView(id: cast.id)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
            .environmentObject(Router())
    }
}
