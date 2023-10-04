//
//  GridView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 03/08/2023.
//

import SwiftUI

struct GridView: View {
    let title: String
    let movies: [Movie]
    
    @State private var isListViewActive = false
    @State private var gridLayout = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        Group {
            if isListViewActive {
                listView
            } else {
                gridView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 5) {
                    listSortButton
                    gridSortButton
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GridView(title: "Movies", movies: Movie.localMovies)
        }
    }
}

private extension GridView {
    
    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 30) {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        PosterCard(movie: movie)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(20)
        }
    }
    
    var listView: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    PosterCard(movie: movie, orientationType: .horizontal)
                }
                .buttonStyle(.plain)
            }
        }
        .listStyle(.plain)
    }
    
    var listSortButton: some View {
        Button {
            isListViewActive = true
        } label: {
            Image(systemName: "square.fill.text.grid.1x2")
                .foregroundStyle(isListViewActive ? .primary : .secondary)
        }
    }
    
    var gridSortButton: some View {
        Button {
            isListViewActive = false
        } label: {
            Image(systemName: "square.grid.2x2")
                .foregroundStyle(isListViewActive ? .secondary : .primary)
        }
    }
}
