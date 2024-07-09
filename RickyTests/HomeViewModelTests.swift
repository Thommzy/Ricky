//
//  HomeViewModelTests.swift
//  RickyTests
//
//  Created by Timothy Obeisun on 7/8/24.
//

import Foundation
import URLSessionNetworkCaller
import Combine
import XCTest
@testable import Ricky

class HomeViewModelTests: XCTestCase {
    
    // Mock network caller to simulate responses
    private class MockNetworkCaller: URLSessionNetworkCaller<Characters> {
        var responseToReturn: Characters!
        var errorToReturn: Error!
        
        override func makeNetworkRequest() -> AnyPublisher<Characters, Error> {
            if let error = errorToReturn {
                return Fail(error: error).eraseToAnyPublisher()
            } else {
                return Just(responseToReturn).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
        }
    }
    
    func testFetchCharacters_Success() {
        // Setup
        let mockNetworkCaller = MockNetworkCaller(baseURL: "https://rickandmortyapi.com/api/", urlPath: "character", method: .get, type: Characters.self, parameter: nil)
        let mockCharacters = Characters(
            results:
                [
                    Character(
                        id: 1,
                        name: "Alan Rails",
                        status: "Dead",
                        species: "Human",
                        gender: "Male",
                        image: "https://rickandmortyapi.com/api/character/avatar/10.jpeg",
                        episode: ["https://rickandmortyapi.com/api/episode/25"]
                    )
                ]
        )
        mockNetworkCaller.responseToReturn = mockCharacters
        
        let viewModel = HomeViewModel(networkCaller: mockNetworkCaller)
        
        // Act
        viewModel.fetchCharacters()
        
        // Assert - Wait for async operations to complete
        let expectation = expectation(description: "Completion of network request")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
        
        // Verify data and state
        XCTAssertEqual(viewModel.characters?.count, 1)
        XCTAssertEqual(viewModel.characters?.first?.id, 1)
        XCTAssertEqual(viewModel.characters?.first?.name, "Alan Rails")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.networkError)
    }
    
    func testFetchCharacters_Error() {
        // Setup
        let mockNetworkCaller = MockNetworkCaller(baseURL: "https://rickandmortyapi.com/api/", urlPath: "character", method: .get, type: Characters.self, parameter: nil)
        let mockError = URLError(.timedOut)
        mockNetworkCaller.errorToReturn = mockError
        
        let viewModel = HomeViewModel(networkCaller: mockNetworkCaller)
        
        // Act
        viewModel.fetchCharacters()
        
        // Assert - Wait for async operations to complete
        let expectation = expectation(description: "Completion of network request")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
        
        // Verify state and error
        XCTAssertNil(viewModel.characters)
        XCTAssertTrue(!viewModel.isLoading)
        XCTAssertNotNil(viewModel.networkError)
        if let error = viewModel.networkError as? URLError {
            XCTAssertEqual(error.code, .timedOut)
        }
    }
}
