//
//  TVDetailViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 12/10/2023.
//

import Foundation

final class TVDetailViewModel: ObservableObject {
    @Published private(set) var tv: TvDetail?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    @MainActor
    func fetchTvDetails(for id: Int) async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            self.tv = try await NetworkingManager.shared.request(.tvDetail(id: id), type: nil)
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

extension TVDetailViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
