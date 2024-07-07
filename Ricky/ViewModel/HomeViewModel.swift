//
//  HomeViewModel.swift
//  Ricky
//
//  Created by Timothy Obeisun on 7/6/24.
//

import Foundation
import Combine
import URLSessionNetworkCaller

final class HomeViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var characters: [Character]?
    @Published var isLoading = false
    @Published var networkError: Error?
    private var networkCaller: URLSessionNetworkCaller<Characters>
    
    init(networkCaller: URLSessionNetworkCaller<Characters> = URLSessionNetworkCaller<Characters>(
        baseURL: "https://rickandmortyapi.com/api/",
        urlPath: "character",
        method: .get,
        type: Characters.self,
        parameter: nil
    )) {
        self.networkCaller = networkCaller
        fetchCharacters()
    }
    
    func fetchCharacters() {
        isLoading = true
        
        networkCaller.makeNetworkRequest()
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.isLoading = false
                    print("Request finished")
                case .failure(let error):
                    isLoading = false
                    networkError = error
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                isLoading = false
                self.characters = response.results
                print("Received response: \(response)")
            })
            .store(in: &cancellables)
    }
}
