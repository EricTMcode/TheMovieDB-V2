//
//  TVViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 08/10/2023.
//

import Foundation

final class TVViewModel: ObservableObject {
    @Published private(set) var popular: [Tv] = []
    
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
    func fetchTV(from endpoint: Endpoint) async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await NetworkingManager.shared.request(endpoint, type: TVResponse.self)
            switch endpoint {
            case .tvPopular(page: page):
                self.popular = response.results
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
}

extension TVViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
