//
//  HomeView.swift
//  Ricky
//
//  Created by Timothy Obeisun on 7/4/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LoaderViewWrapper(isLoading: viewModel.isLoading)
                if let characters = viewModel.characters {
                    ForEach(characters, id: \.id) { character in
                        NavigationLink(destination: DetailView(character: character)) {
                            CardView(character: character)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .alert(isPresented: Binding<Bool>(
                get: { self.viewModel.networkError != nil },
                set: { _ in self.viewModel.networkError = nil }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.networkError?.localizedDescription ?? "Unknown Error"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .padding(.horizontal, 10)
            .navigationTitle("Home")
        }
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
