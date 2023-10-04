//
//  GridViewModel.swift
//  TheMovieDB-V2
//
//  Created by Eric on 04/10/2023.
//

import SwiftUI

final class GridViewModel: ObservableObject {
    
    @Published var isListViewActive = false
    @Published private(set) var gridLayout = Array(repeating: GridItem(.flexible()), count: 3)
}
