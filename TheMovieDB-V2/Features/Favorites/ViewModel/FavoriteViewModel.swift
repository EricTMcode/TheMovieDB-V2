//
//  FavoriteViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 04/09/2023.
//

import Foundation

enum SortOption: Int {
    case name = 1
    case date = 2
}

class FavoriteViewModel: ObservableObject {
    @Published private(set) var favoriteMovies: [Movie] = []
    @Published var isShowingSortOptions = false
    
    let savePath = FileManager.documentsDirectory.appending(path: "favoriteMovie")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Movie].self, from: data) {
                favoriteMovies = decoded
                return
            }
        }
        favoriteMovies = []
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(favoriteMovies)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ movie: Movie) {
        favoriteMovies.append(movie)
        save()
    }
    
    
    func remove(_ movie: Movie) {
        if let indexToDelete = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            favoriteMovies.remove(at: indexToDelete)
            save()
        }
    }
    
    func contains(_ movie: Movie) -> Bool {
        favoriteMovies.contains(where: { $0.id == movie.id })
    }
    
    func toogleFav(_ movie: Movie) {
        if contains(movie) {
            remove(movie)
        } else {
            add(movie)
        }
    }
}

