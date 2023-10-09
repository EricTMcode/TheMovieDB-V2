//
//  PosterCarouselView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 27/07/2023.
//

import SwiftUI

struct PosterCarouselView<T: MovieProtocol>: View {
    let title: String
    let content: [T]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Spacer()
                
                NavigationLink(value: content) {
                    Text("Show all")
                        .font(.callout)
                        .fontWeight(.regular)
                }
                .tint(.orange)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 12) {
                    ForEach(content) { movie in
                        NavigationLink(value: movie) {
                            PosterCard(content: movie)
                                .frame(width: 94, height: 176)
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
            PosterCarouselView<Movie>(title: "Movie of the day", content: Movie.localMovies)
        }
    }
}
