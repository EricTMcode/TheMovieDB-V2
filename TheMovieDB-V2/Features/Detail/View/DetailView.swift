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
        DetailView(id: Movie.localMovie.id)
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
                }
                .frame(height: UIScreen.main.bounds.height * 0.4)
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
            
            Text("★ \(movie.voteAverage, specifier: "%.1f")   \("1h25")   \("2023")")
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
}
