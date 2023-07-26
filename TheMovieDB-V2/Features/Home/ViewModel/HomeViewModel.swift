//
//  HomeViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 26/07/2023.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var nowPlaying: [Movie] = []
    @Published private(set) var upcoming: [Movie] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    private var page = 1
    private var totalPages: Int?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    func fetchMovies() async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await NetworkingManager.shared.request(.nowPlaying(page: page), type: MovieResponse.self)
            self.nowPlaying = response.results
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}

extension HomeViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
