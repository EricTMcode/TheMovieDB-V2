//
//  PosterCard.swift
//  TheMovieDB-V2
//
//  Created by Eric on 27/07/2023.
//

import SwiftUI

struct PosterCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RectangleView()
                
                AsyncImage(url: movie.posterURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Image(systemName: "video")
                    } else {
                        ProgressView()
                    }
                }
            }
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .lineLimit(1)
                    .font(.caption)
                
                Text("☆ \(movie.voteAverage, specifier: "%.1f")")
                    .foregroundColor(.secondary)
                    .font(.caption.bold())
            }
        }
        .frame(width: 90, height: 150)
    }
}

struct PosterCard_Previews: PreviewProvider {
    static var previews: some View {
        PosterCard(movie: Movie.localMovie)
            .frame(width: 90, height: 150)
    }
}