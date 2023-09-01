//
//  PersonView.swift
//  TheMovieDB-V2
//
//  Created by Eric on 01/09/2023.
//

import SwiftUI

struct PersonView: View {
    @StateObject private var vm = PersonViewModel()
    let id: Int
    
    
    var body: some View {
        VStack {
            if vm.person != nil {
                PersonDetailView(person: vm.person!)
            }
        }
        .task {
            await vm.fetchPerson(for: id)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(id: 1087262)
        PersonView(id: 54693)
    }
}

struct PersonDetailView: View {
    @State private var showFullDescription = false
    let person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(person.name)
            PersonPictureView
            PersonBiographyView
        }
        .padding(.horizontal)
    }
    
    private var PersonPictureView: some View {
        ZStack {
            RectangleView()
            AsyncImage(url: person.profileURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    ZStack {
                        Image(systemName: "person")
                            .font(.system(size: 48))
                            .opacity(0.5)
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .frame(width: 130, height: 180)
        .shadow(radius: 12)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.4), lineWidth: 1)
        }
    }
    
    private var PersonBiographyView: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextDetailTitle(text: "Biography")
            VStack(alignment: .leading) {
                Text(person.biographyText)
                    .lineLimit(showFullDescription ? nil : 4)
                if !person.biography.isEmpty  {
                    Button {
                        showFullDescription.toggle()
                    } label: {
                        Text(showFullDescription ? "See Less..." : "Read more...")
                            .padding(.vertical, -4)
                    }
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
