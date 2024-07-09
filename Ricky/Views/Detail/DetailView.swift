//
//  DetailView.swift
//  Ricky
//
//  Created by Timothy Obeisun on 7/4/24.
//

import SwiftUI

struct DetailView: View {
    var character: Character
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(character.name ?? "")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                    Text(character.gender ?? "")
                        .font(.body)
                    Text("Episodes: \(character.episode?.count ?? 0)")
                        .bold()
                        .font(.body)
                    AsyncImage(url: URL(string: character.image ?? "")) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .font(.largeTitle)
                                .cornerRadius(5.0)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5.0)
                        default:
                            ProgressView()  
                        }
                    }
                    .scaledToFit()
                    Spacer()
                    
                }
                .padding(.leading)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
        })
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: Character(id: 1, name: "Alan Rails", status: "Dead", species: "Human", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/10.jpeg", episode: ["https://rickandmortyapi.com/api/episode/25"]))
    }
}
