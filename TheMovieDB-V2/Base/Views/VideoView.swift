//
//  VideoView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 04/10/2023.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    
    let key: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(key)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}
