//
//  TvDetailModelView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 12/10/2023.
//

import SwiftUI

struct TvDetailModelView: View {
    let tv: Tv
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                GeometryReader { geo in
                    ZStack(alignment: .bottomLeading) {
                        TvDetailImageView
                            .frame(width: geo.size.width, height: GeometryHelper.getHeightForHeaderImage(geo))
                        
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.5))
                            .frame(width: geo.size.width, height: 80)
                        
                        TvDetailTitleView
                    }
                    .offset(x: 0, y: GeometryHelper.getOffsetForHeaderImage(geo))
                }
                .frame(height: UIScreen.main.bounds.height * 0.5)
                
                VStack(alignment: .leading, spacing: 20) {
                    TvDetailOverviewView
                    TvDetailDistributionView
                    TvDetailTrailerView
                }
                .padding(.horizontal)
                .padding(.bottom, 90)
            }
        }
        .ignoresSafeArea()
    }
    
    private var TvDetailImageView: some View {
        AsyncImage(url: tv.backdropOriginalURL) { phase in
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
            Text(tv.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            Text("★ \(tv.voteAverageText) - 2011 - Status: In production")
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
    
    private var TvDetailOverviewView: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextDetailTitle(text: "Overview")
            Text(tv.overview)
                .font(.callout)
        }
        .padding(.top, 5)
    }
    
    private var TvDetailDistributionView: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextDetailTitle(text: "Distribution")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 10) {
                    if let cast = tv.cast, !cast.isEmpty {
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
                                    .cornerRadius(8)
                                    
                                    Group {
                                        Text(cast.name)
                                        Text(cast.character)
                                            .foregroundStyle(.secondary)
                                    }
                                    .font(.footnote)
                                }
                                .frame(width: 80)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }
    
    private var TvDetailTrailerView: some View {
        VStack(alignment: .leading, spacing: 15) {
            if tv.video != nil {
                TextDetailTitle(text: "Trailer")
                ForEach(tv.video!.prefix(1)) { video in
                    VideoView(key: video.key)
                        .aspectRatio(16/9,contentMode: .fit)
                }
            }
        }
    }
}

#Preview {
    TvDetailModelView(tv: Tv.localTv)
}

