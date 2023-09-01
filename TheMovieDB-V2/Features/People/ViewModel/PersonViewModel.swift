//
//  PersonViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 01/09/2023.
//

import Foundation

class PersonViewModel: ObservableObject {
    @Published private(set) var person: Person?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    @Published var showFullDescription = false
    
    func fetchPerson(for id: Int) async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            self.person = try await NetworkingManager.shared.request(.person(id: id), type: nil)
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

extension PersonViewModel {
    enum ViewState {
        case loading
        case finished
    }
}
