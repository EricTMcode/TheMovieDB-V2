//
//  TVView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 03/08/2023.
//

import SwiftUI

struct TVView: View {
    @StateObject var vm = TVViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(vm.popular) { show in
                            PosterCard(content: show)
                                .frame(width: 100, height: 200)
                    }
                }
            }
            .task {
                await vm.fetchTV(from: .tvPopular(page: vm.page))
            }
        }
    }
}

struct TVView_Previews: PreviewProvider {
    static var previews: some View {
        TVView()
    }
}
