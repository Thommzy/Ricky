//
//  LoaderViewWrapper.swift
//  Ricky
//
//  Created by Timothy Obeisun on 7/7/24.
//

import SwiftUI

struct LoaderViewWrapper: UIViewRepresentable {
    var isLoading: Bool
    
    func makeUIView(context: Context) -> LoaderView {
        return LoaderView()
    }
    
    func updateUIView(_ uiView: LoaderView, context: Context) {
        isLoading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
