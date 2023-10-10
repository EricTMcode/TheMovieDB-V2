//
//  SettingsView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 29/09/2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("interfaceTheme") private var interfaceTheme: InterfaceTheme = .auto
    @AppStorage("language") private var language: Language = .en
    @EnvironmentObject var router: Router
    
    var body: some View {
            Form {
                Section {
                    Picker("Language", selection: $language) {
                        ForEach(Language.allCases, id: \.self) { lang in
                            Text(lang.rawValue)
                                .onTapGesture {
                                    Endpoint.selectedLanguage = lang
                                }
                        }
                    }
                    Picker("Theme", selection: $interfaceTheme) {
                        ForEach(InterfaceTheme.allCases, id: \.self) { theme in
                            Text(theme.name).tag(theme)
                        }
                    }
                } header: {
                    Text("Display")
                } footer: {
                    Text("System settings will override Dark Mode and use the current device theme")
                }
                Section {
                    Link(destination: URL(string: Constants.twitter)!) {
                        Label("Follow me on Twitter @erictmcode", systemImage: "link")
                    }
                    Link(destination: URL(string: Constants.email)!) {
                        Label("Contact me via email", systemImage: "envelope")
                    }
                }
                .foregroundStyle(Theme.textColor)
                .font(.system(size: 16, weight: .medium))
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .tint(.accentColor)
            .preferredColorScheme(interfaceTheme == .auto ? nil : (interfaceTheme == .dark ? .dark : .light))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        router.resetAllPath()
                    } label: {
                        returnButtonView()
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .preferredColorScheme(.dark)
            .environmentObject(Router())
    }
}
