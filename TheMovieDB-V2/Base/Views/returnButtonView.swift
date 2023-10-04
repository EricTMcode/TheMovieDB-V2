//
//  returnButtonView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 04/10/2023.
//

import SwiftUI

struct returnButtonView: View {
    var body: some View {
        Image(systemName: "chevron.left")
            .font(.title3)
            .foregroundStyle(.orange)
            .shadow(radius: 20)
    }
}

#Preview {
    returnButtonView()
}
