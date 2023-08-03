//
//  MovieDetailTitle.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/07/2023.
//

import SwiftUI

struct MovieDetailTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .bold()
    }
}

struct MovieDetailTitle_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailTitle(text: "Hello")
    }
}
