//
//  FavoriteViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 04/09/2023.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var favoriteMovies: [Movie]
    
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
    
    func contains(_ movie: Movie) -> Bool {
        favoriteMovies.contains(where: { $0.id == movie.id })
    }
    
    func remove(_ movie: Movie) {
        if let indexToDelete = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            favoriteMovies.remove(at: indexToDelete)
            save()
        }
    }
}
