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

protocol MediaProtocol: Identifiable, Hashable {
    var id: Int { get }
    var posterString: String { get }
    var title: String { get }
    var voteAverageText: String { get }
    var yearText: String { get }
    var backdropURL: URL { get }
}


struct PosterCard<T: MediaProtocol>: View {
    let content: T
    var orientationType: PosterCardOrientationType = .vertical
    
    var body: some View {
        containerView
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
                    .frame(width: 60 ,height: 120)
                textView
            }
        }
    }
    
    private var imageView: some View {
        ZStack {
            RectangleView()

            MovieRemoteImage(urlString: content.posterString)
                .scaledToFill()
            
//            AsyncImage(url: movie.posterURL) { phase in
//                if let image = phase.image {
//                    image
//                        .resizable()
//                        .scaledToFill()
//                } else if phase.error != nil {
//                    Image(systemName: "video")
//                } else {
//                    ProgressView()
//                }
//            }
        }
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
    }
    
    @ViewBuilder
    private var textView: some View {
        if case .vertical = orientationType {
            VStack(alignment: .leading) {
                Text(content.title)
                    .font(.caption)
                
                Text("☆ \(content.voteAverageText)")
                    .foregroundColor(.secondary)
                    .font(.caption.bold())
            }
            .lineLimit(1)
        } else {
            VStack(alignment: .leading) {
                Text(content.title)
                    .font(.headline)
                
                Text("☆ \(content.voteAverageText) - \(content.yearText)")
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
            PosterCard(content: Movie.localMovie, orientationType: .vertical)
                .frame(width: 204, height: 306)
                .padding()
            
            PosterCard(content: Movie.localMovie, orientationType: .horizontal)
                .frame(width: 204, height: 306)
        }
    }
}
