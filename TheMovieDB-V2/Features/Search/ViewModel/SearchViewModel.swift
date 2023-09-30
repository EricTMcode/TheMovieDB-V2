//
//  SearchViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 30/09/2023.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published private(set) var movies: [Movie]?
    @Published var query = ""
    @Published var phase: DataSearchPhase<[Movie]> = .empty
    @Published var cancellables = Set<AnyCancellable>()
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func startObserve() {
        guard cancellables.isEmpty else { return }
        
        $query
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .sink { [weak self] _ in
                self?.phase = .empty; self?.movies?.removeAll()
            }
            .store(in: &cancellables)
        
        $query
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { query in
                Task { [weak self] in
                    guard let self = self else { return }
                    await self.searchMovie(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    
    @MainActor
    func searchMovie(query: String) async {
        phase = .empty
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return }
        
        do {
            self.movies = try await NetworkingManager.shared.request(.search(query: trimmedQuery), type: MovieResponse.self).results
            guard trimmedQuery == self.trimmedQuery else { return }
            phase = .success(movies ?? [])
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
            guard trimmedQuery == self.trimmedQuery else { return }
            phase = .failure(error)
        }
        
        
    }
    
}

enum DataSearchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
