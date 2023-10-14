//
//  TVDetailView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 12/10/2023.
//

import SwiftUI

struct TVDetailView: View {
    @StateObject private var vm = TVDetailViewModel()
    @EnvironmentObject var router: Router
    
    let id: Int
    
    var body: some View {
        VStack {
            if vm.tv != nil {
                //                TvDetailModelView(tv: vm.tv!)
                    ContentDetailView(content: vm.tv!)
            }
        }
        .navigationBarBackButtonHidden()
        .task {
            await vm.fetchTvDetails(for: id)
        }
        .overlay {
            if vm.viewState == .loading {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.resetTVPath()
                } label: {
                    returnButtonView()
                }
            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Retry") {
                Task {
                    await vm.fetchTvDetails(for: id)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TVDetailView(id: 1396)
            .environmentObject(Router())
    }
}
