//
//  PreviewProvider.swift
//  TheMovieDB-V2
//
//  Created by Eric on 27/07/2023.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    private init() {}
    
    let movie = Movie(id: 338762,
                      title: "Bloodshot",
                      overview: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.",
                      posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
                      backdropPath: "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg",
                      releaseDate: "2020-03-05",
                      voteAverage: 7.1,
                      runtime: 110)
}
