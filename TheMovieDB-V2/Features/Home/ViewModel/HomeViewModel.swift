//
//  HomeViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published private(set) var nowPlaying: [Movie] = []
    @Published private(set) var upcoming: [Movie] = []
    @Published private(set) var topRated: [Movie] = []
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    @Published var hasAppeared = false
    
    @Published var page = 1
    private var totalPages: Int?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    @MainActor
    func fetchMovies(from endpoint: Endpoint) async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await NetworkingManager.shared.request(endpoint, type: MovieResponse.self)
            switch endpoint {
            case .nowPlaying(page: page):
                self.nowPlaying = response.results
            case .upcoming(page: page):
                self.upcoming = response.results
            case .topRated(page: page):
                self.topRated = response.results
            default:
                break
            }
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func fetchGridMovies(from endpoint: Endpoint) async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await NetworkingManager.shared.request(endpoint, type: MovieResponse.self)
            switch endpoint {
            case .nowPlaying(page: page):
                self.movies = response.results
            case .upcoming(page: page):
                self.movies = response.results
            case .topRated(page: page):
                self.movies = response.results
            default:
                break
            }
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfMovies(from endpoint: Endpoint) async {
        
        guard page != totalPages else { return }
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        do {
            let response = try await NetworkingManager.shared.request(endpoint, type: MovieResponse.self)
            self.totalPages = response.totalPages
            self.movies += response.results
           
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func hasReachedEnd(of movie: Movie) -> Bool {
        movies.last?.id == movie.id
    }
    
    
    func populateMovies() async {
        await fetchMovies(from: .nowPlaying(page: page))
        await fetchMovies(from: .upcoming(page: page))
        await fetchMovies(from: .topRated(page: page))
    }
}

extension HomeViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension HomeViewModel {
    func reset() {
        if viewState == .finished {
            movies.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
