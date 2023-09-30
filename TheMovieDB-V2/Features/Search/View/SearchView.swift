//
//  SearchView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 03/08/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if vm.movies != nil {
                    ForEach(vm.movies!) { movie in
                        PosterCard(movie: movie, orientationType: .horizontal)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Search")
            .searchable(text: $vm.query, prompt: "Search movies")
            .onAppear { vm.startObserve() }
            .overlay(overlayView)
            .alert("Application Error", isPresented: $vm.hasError, presenting: vm.error) { _ in
                Button("OK") {}
            } message: { error in
                Text(error.errorDescription ?? "Try again later")
            }
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch vm.phase {
        case .empty:
            if vm.trimmedQuery.isEmpty {
                EmptyPlaceHolderView(text: "Search your favorite movie", subText: nil, image: "magnifyingglass")
            } else {
                ProgressView()
            }
        case .success(let values) where values.isEmpty:
            EmptyPlaceHolderView(text: "No results", subText: nil, image: "film")
            
        case .failure(let error):
            Text(error.localizedDescription)
            
        default: EmptyView()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
