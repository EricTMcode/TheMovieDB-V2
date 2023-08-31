//
//  PosterCarouselView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 27/07/2023.
//

import SwiftUI

struct PosterCarouselView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Spacer()
                
                NavigationLink(value: movies) {
                    Text("Show all")
                        .font(.callout)
                        .fontWeight(.regular)
                }
                .tint(.orange)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 15) {
                    ForEach(movies) { movie in
                        NavigationLink(value: movie) {
                            PosterCard(movie: movie)
                                .frame(width: 105, height: 175)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}

struct PosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PosterCarouselView(title: "Movie of the day", movies: Movie.localMovies)
        }
    }
}
