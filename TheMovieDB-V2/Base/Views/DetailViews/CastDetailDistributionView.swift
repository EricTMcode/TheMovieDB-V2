//
//  CastDetailDistributionView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 13/10/2023.
//

import SwiftUI

struct CastDetailDistributionView<T: MediaProtocol>: View {
    
    let content: T
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextDetailTitle(text: "Distribution")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 10) {
                    if let cast = content.cast, !cast.isEmpty {
                        ForEach(cast.prefix(9)) { cast in
                            NavigationLink(value: cast) {
                                VStack(alignment: .leading) {
                                    ZStack {
                                        RectangleView()
                                            .shadow(radius: 4)
                                        
                                        AsyncImage(url: cast.profileURL) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .shadow(radius: 4)
                                            } else if phase.error != nil {
                                                Image(systemName: "person")
                                                    .font(.system(size: 25))
                                                    .opacity(0.5)
                                            } else {
                                                ProgressView()
                                            }
                                        }
                                    }
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(20)
                                    
                                    Text(cast.name)
                                    Text(cast.character)
                                        .foregroundStyle(.secondary)
                                }
                                .font(.footnote)
                                .frame(width: 80)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CastDetailDistributionView<Tv>(content: Tv.localTv)
}
