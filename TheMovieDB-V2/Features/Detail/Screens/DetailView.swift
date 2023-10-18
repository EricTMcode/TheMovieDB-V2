//
//  DetailView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/07/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm = DetailViewModel()
    @EnvironmentObject var favorite: Favorite
    @EnvironmentObject var router: Router
    
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
        .navigationBarBackButtonHidden()
        .overlay {
            if vm.viewState == .loading {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.resetAllPath()
                } label: {
                    returnButtonView()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                if vm.movie != nil {
                    ShareLink("Movie Recommendation",
                              item: URL(string: "\(Constants.shareMovieURL)\(id)")!,
                              subject: Text("Enjoy the Movie"),
                              message: Text(vm.movie!.shareDescription),
                              preview: SharePreview(Text("\(vm.movie!.title)")))
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                if vm.movie != nil {
                    favoritesButton
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
                .environmentObject(Favorite())
                .environmentObject(Router())
        }
    }
}

private extension DetailView {
    
    var favoritesButton: some View {
        Image(systemName: favorite.contains(vm.movie!) ? "star.fill" : "star")
            .foregroundColor(.orange)
            .onTapGesture {
                favorite.toggleFav(vm.movie!)
            }
    }
}
