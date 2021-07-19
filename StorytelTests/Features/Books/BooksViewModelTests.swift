//
//  BooksViewModelTests.swift
//  StorytelTests
//
//  Created by Anil Goktas on 7/19/21.
//

@testable import Storytel
import XCTest
import Combine

final class BooksViewModelTests: BaseTestCase {
    
    // MARK: - Properties
    
    let networkRouter = BooksNetworkRoutingMock()
    
    // MARK: - Factory
    
    func makeSubject() -> BooksViewModel {
        BooksViewModel(networkRouter: networkRouter)
    }
    
    // MARK: - Tests
    
    func test_searchQuery_shouldUseNetworkRouter_withoutNextPageToken() {
        // Given
        let query = "unit testing"
        let response = BooksNetworkRouter.Search.Response(nextPageToken: "10", books: [])
        let future = Future<BooksNetworkRouter.Search.Response, Error> {
            promise in promise(.success(response))
        }.eraseToAnyPublisher()
        
        networkRouter.given(
            .search(
                query: .value(query),
                pageToken: .value(nil),
                willReturn: future
            )
        )
        let subject = makeSubject()
        
        // When
        subject.search(query: query)
        
        // Then
        networkRouter.verify(
            .search(query: .value(query), pageToken: .value(nil))
        )
    }
    
    func test_fetchNextPage_shouldUseNetworkRouter_withNextPageToken() {
        // Given
        let query = "unit testing"
        let nextPageTokenString = "10"
        
        let response = BooksNetworkRouter.Search.Response(nextPageToken: nextPageTokenString, books: [.harryPottcastFlammernesPokal()])
        let future = Future<BooksNetworkRouter.Search.Response, Error> {
            promise in promise(.success(response))
        }.eraseToAnyPublisher()
        
        networkRouter.given(
            .search(
                query: .value(query),
                pageToken: .any,
                willReturn: future
            )
        )
        let subject = makeSubject()
        
        // When
        subject.search(query: query)
        subject.fetchNextPage()
        
        // Then
        networkRouter.verify(
            .search(query: .value(query), pageToken: .value(nil))
        )
        networkRouter.verify(
            .search(query: .value(query), pageToken: .value(nextPageTokenString))
        )
        XCTAssertEqual(
            subject.books.count,
            2,
            "Same book added twice. This might be a bug given books already have an identifier."
        )
    }
    
    func test_searchQuery_shouldUpdateBooks() {
        // Given
        var didReceiveOnBooksUpdate = false
        let query = "unit testing"
        let books: [Book] = [.harryPotterAndThePhilosophersStone(), .harryPottcastFlammernesPokal()]
        
        let response = BooksNetworkRouter.Search.Response(
            nextPageToken: "10",
            books: books
        )
        let future = Future<BooksNetworkRouter.Search.Response, Error> {
            promise in promise(.success(response))
        }.eraseToAnyPublisher()
        
        networkRouter.given(
            .search(
                query: .value(query),
                pageToken: .value(nil),
                willReturn: future
            )
        )
        let subject = makeSubject()
        subject.onBooksUpdate = { _ in didReceiveOnBooksUpdate = true }
        
        // When
        subject.search(query: query)
        
        // Then
        networkRouter.verify(
            .search(query: .value(query), pageToken: .value(nil))
        )
        XCTAssertEqual(subject.books.count, books.count)
        XCTAssertTrue(didReceiveOnBooksUpdate)
    }
    
}
