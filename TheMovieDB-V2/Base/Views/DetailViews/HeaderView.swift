//
//  HeaderView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 12/10/2023.
//

import SwiftUI

struct HeaderView<T: MediaProtocol>: View {
    
    let content: T
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                GeometryReader { geo in
                    ZStack(alignment: .bottomLeading) {
                        BackdropView
                            .frame(width: geo.size.width, height: GeometryHelper.getHeightForHeaderImage(geo))
                        
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.5))
                            .frame(width: geo.size.width, height: 80)
                        
                        TvDetailTitleView
                    }
                    .offset(x: 0, y: GeometryHelper.getOffsetForHeaderImage(geo))
                }
                .frame(height: UIScreen.main.bounds.height * 0.5)
            }
        }
        .ignoresSafeArea()
    }
    
    private var BackdropView: some View {
        AsyncImage(url: content.backdropOriginalURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Image(systemName: "film")
                    .font(.system(size: 48))
                    .opacity(0.5)
            } else {
                ProgressView()
            }
        }
    }
    
    private var TvDetailTitleView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(content.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            Text("★ \(content.voteAverageText) - 2011 - Status: In production")
                .font(.callout)
                .fontWeight(.medium)
            
            Text("Action, Thriller, Crime")
                .font(.footnote)
        }
        .foregroundStyle(.white.opacity(0.7))
        .shadow(radius: 7)
        .padding(.leading)
        .padding(.bottom,8)
    }
}

#Preview {
    HeaderView<TvDetail>(content: TvDetail.localTv)
}
