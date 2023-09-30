//
//  EmptyPlaceHolderView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 30/09/2023.
//

import SwiftUI

struct EmptyPlaceHolderView: View {
    let text: String
    let subText: String?
    let image: String?
    
    var body: some View {
        VStack(spacing: 10) {
            if let image = image {
                Image(systemName: image)
                    .font(.system(size: 48))
            }
            VStack(spacing: 3) {
                Text(text)
                Text(subText ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    EmptyPlaceHolderView(text: "No Favorite Movies", subText: "You can add movie by pressing the star on the movie*" , image: "film")
}
