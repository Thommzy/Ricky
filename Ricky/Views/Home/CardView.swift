//
//  CardView.swift
//  Ricky
//
//  Created by Timothy Obeisun on 7/4/24.
//

import SwiftUI

struct CardView: View {
    var character: Character
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text(character.name ?? "")
                    .font(.headline)
                Text(character.status ?? "")
                    .font(.subheadline)
            }
            
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                HStack {
                    Spacer()
                    Text("Episodes:").bold() + Text(" \(character.episode?.count ?? 0)")
                        .font(.subheadline)
                }
                HStack {
                    Spacer()
                    Text("Gender:").bold() + Text(" \(character.gender ?? "")")
                        .font(.subheadline)
                }
                HStack {
                    Spacer()
                    Text("Species:").bold() + Text(" \(character.species ?? "")")
                        .font(.subheadline)
                }
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .shadow(radius: 5)
        .padding(.vertical, 5)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            character: Character(
                id: 1,
                name: "Alan Rails",
                status: "Dead",
                species: "Human",
                gender: "Male",
                image: "https://rickandmortyapi.com/api/character/avatar/10.jpeg",
                episode: ["https://rickandmortyapi.com/api/episode/25"]
            )
        )
    }
}
