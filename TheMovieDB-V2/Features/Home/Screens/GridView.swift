//
//  GridView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 03/08/2023.
//

import SwiftUI

struct GridView: View {
    @StateObject var vm = GridViewModel()
    @EnvironmentObject var router: Router
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        Group {
            if vm.isListViewActive {
                listView
            } else {
                gridView
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.resetAllPath()
                } label: {
                    returnButtonView()
                }
            }
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
                .environmentObject(Router())
        }
    }
}

private extension GridView {
    
    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: vm.gridLayout, spacing: 30) {
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
            vm.isListViewActive = true
        } label: {
            Image(systemName: "square.fill.text.grid.1x2")
                .foregroundStyle(vm.isListViewActive ? .primary : .secondary)
        }
    }
    
    var gridSortButton: some View {
        Button {
            vm.isListViewActive = false
        } label: {
            Image(systemName: "square.grid.2x2")
                .foregroundStyle(vm.isListViewActive ? .secondary : .primary)
        }
    }
}
