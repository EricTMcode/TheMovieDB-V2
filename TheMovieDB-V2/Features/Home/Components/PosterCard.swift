//
//  PosterCard.swift
//  TheMovieDB-V2
//
//  Created by Eric on 27/07/2023.
//

import SwiftUI

enum PosterCardOrientationType {
    case vertical
    case horizontal
}

struct PosterCard: View {
    let movie: Movie
    var orientationType: PosterCardOrientationType = .vertical
    
    var body: some View {
        containerView
        
//        .frame(width: 90, height: 150)
    }
    
    @ViewBuilder
    private var containerView: some View {
        if case .vertical = orientationType {
            VStack(alignment: .leading) {
                imageView
                textView
            }
        } else {
            HStack(alignment: .top, spacing: 16) {
                imageView
                    .frame(width: 61, height: 92)
                textView
            }
        }
    }
    
    private var imageView: some View {
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
    }
    
    @ViewBuilder
    private var textView: some View {
        if case .vertical = orientationType {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.caption)
                
                Text("☆ \(movie.voteAverage, specifier: "%.1f")")
                    .foregroundColor(.secondary)
                    .font(.caption.bold())
            }
            .lineLimit(1)
        } else {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                
                Text("☆ \(movie.voteAverage, specifier: "%.1f") - \(movie.yearText)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            .lineLimit(1)
        }
    }
}


struct PosterCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PosterCard(movie: Movie.localMovie, orientationType: .vertical)
                .frame(width: 90, height: 150)
            
            PosterCard(movie: Movie.localMovie, orientationType: .horizontal)
                .frame(width: 200, height: 20)
        }
    }
}
