//
//  DetailContentView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 12/10/2023.
//

import SwiftUI

struct DetailContentView<T: MediaProtocol>: View {
    
    let content: T
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextDetailTitle(text: "Overview")
            Text(content.overview)
                .font(.callout)
        }
        .padding(.top, 5)
    }
}

#Preview {
    DetailContentView<TvDetail>(content: TvDetail.localTv)
        .padding(.horizontal)
}
