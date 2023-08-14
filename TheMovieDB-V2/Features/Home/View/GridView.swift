//
//  GridView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 03/08/2023.
//

import SwiftUI

struct GridView: View {
    let title: String
    let movies: [Movie]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(movies) { movie in
                        PosterCard(movie: movie)
                    }
                }
                .padding(20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(title: "Movies", movies: Movie.localMovies)
    }
}
