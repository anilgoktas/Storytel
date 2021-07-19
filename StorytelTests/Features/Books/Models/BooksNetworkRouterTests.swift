//
//  BooksNetworkRouterTests.swift
//  StorytelTests
//
//  Created by Anil Goktas on 7/19/21.
//

@testable import Storytel
import XCTest
import SwiftyJSON
import Combine

final class BooksNetworkRouterTests: BaseTestCase {
    
    // MARK: - Properties
    
    let subject = BooksNetworkRouter()
    
    // MARK: - Tests
    
    func test_search_shouldUseSession() {
        // Given
        let future = Future<JSON, Error> { promise in promise(.success(JSON())) }.eraseToAnyPublisher()
        mocker.network.given(
            .perform(
                .matching({ urlRequest in
                    urlRequest.url?.absoluteString.contains("query") ?? false
                }),
                willReturn: future
            )
        )
        
        // When
        _ = subject
            .search(query: "", pageToken: nil)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
        
        // Then
        mocker.network.verify(
            .perform(
                .matching({ urlRequest in
                    urlRequest.url?.absoluteString.contains("query") ?? false
                })
            )
        )
    }
    
    func test_search_shouldParseResponse() {
        // Given
        let book = Book.harryPotterAndThePhilosophersStone()
        var dict = [String: Any]()
        dict["nextPageToken"] = "10"
        dict["items"] = [book.dictionaryValue]
        let responseJSON = JSON(dict)
        
        let future = Future<JSON, Error> { promise in promise(.success(responseJSON)) }.eraseToAnyPublisher()
        mocker.network.given(
            .perform(
                .matching({ urlRequest in
                    urlRequest.url?.absoluteString.contains("query") ?? false
                }),
                willReturn: future
            )
        )
        
        // When
        _ = subject
            .search(query: "", pageToken: nil)
            .sink(receiveCompletion: { _ in }, receiveValue: { response in
                // Then
                XCTAssertEqual(response.nextPageToken, "10")
                XCTAssertEqual(response.books.count, 1)
                XCTAssertEqual(response.books.first?.title, book.title)
            })
    }
    
}
