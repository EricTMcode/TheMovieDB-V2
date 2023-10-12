//
//  BackdropCarouselView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 28/07/2023.
//

import SwiftUI

struct BackdropCarouselView<T: MediaProtocol>: View {
    let content: [T]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 20) {
                ForEach(content) { movie in
                    NavigationLink(value: movie) {
                        BackdropCard(content: movie)
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
        BackdropCarouselView(content: Movie.localMovies)
    }
}
