//
//  DetailView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/07/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm = DetailViewModel()
    let id: Int
    
    var body: some View {
        VStack {
            if vm.movie != nil {
                MovieDetailView(movie: vm.movie!)
            }
        }
        .task {
            await vm.fetchDetails(for: id)
        }
        .overlay {
            if vm.viewState == .loading {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "star")
                }
            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Retry") {
                Task {
                    await vm.fetchDetails(for: id)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(id: Movie.localMovie.id)
        }
    }
}

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                GeometryReader { geo in
                    ZStack(alignment: .bottomLeading) {
                        MovieDetailImageView
                            .frame(width: geo.size.width, height: GeometryHelper.getHeightForHeaderImage(geo))
                        
                        Rectangle()
                            .foregroundColor(.black.opacity(0.5))
                            .frame(width: geo.size.width, height: 80)
                        
                        MovieDetailTitleView
                    }
                    .offset(x: 0, y: GeometryHelper.getOffsetForHeaderImage(geo))
                }
                .frame(height: UIScreen.main.bounds.height * 0.5)
                
                VStack(alignment: .leading, spacing: 20) {
                    MovieDetailOverviewView
                    MovieDetailDistributionView
                }
                .padding(.bottom, 90)
            }
        }
        .ignoresSafeArea()
    }
    
    private var MovieDetailImageView: some View {
        AsyncImage(url: movie.backdropOriginalURL) { phase in
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
    
    private var MovieDetailTitleView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(movie.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text("★ \(movie.voteAverage, specifier: "%.1f")   \(movie.durationText)   \("2023")")
                .font(.callout)
                .fontWeight(.medium)
            
            Text(movie.genreText)
                .font(.footnote)
        }
        .foregroundColor(.white.opacity(0.7))
        .shadow(radius: 7)
        .padding(.leading)
        .padding(.bottom, 8)
    }
    
    private var MovieDetailOverviewView: some View {
        VStack(alignment: .leading, spacing: 12) {
            MovieDetailTitle(text: "Overview")
            Text(movie.overview)
                .font(.callout)
        }
        .padding(.top, 5)
        .padding(.horizontal)
    }
    
    private var MovieDetailDistributionView: some View {
        VStack(alignment: .leading, spacing: 15) {
            MovieDetailTitle(text: "Distribution")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 15) {
                    if let cast = movie.credits?.cast, !cast.isEmpty {
                        ForEach(cast.prefix(9)) { cast in
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
                                    .font(.footnote)
                                Text(cast.character)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 80)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
