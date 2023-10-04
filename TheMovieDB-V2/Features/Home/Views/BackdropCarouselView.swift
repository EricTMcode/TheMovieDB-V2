//
//  BackdropCarouselView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 28/07/2023.
//

import SwiftUI

struct BackdropCarouselView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 20) {
                ForEach(movies.shuffled()) { movie in
                    NavigationLink(value: movie) {
                        BackdropCard(movie: movie)
                            .frame(width: 332)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.leading)
        }
    }
}

struct BackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        BackdropCarouselView(movies: Movie.localMovies)
    }
}
