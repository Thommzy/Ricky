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
                    
                    Image(systemName: "multiply.circle.fill")
                        .background(Color.green)
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
            Image(systemName: "chevron.left") // Back arrow icon
                .foregroundColor(.blue)
        })
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(card: Card(title: "Tim Shrek",description: "Welcome my Man", episodes: "12", species: "Human", gender: "Male", status: "Alive"))
//    }
//}
