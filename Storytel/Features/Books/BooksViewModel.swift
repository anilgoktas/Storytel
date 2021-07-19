//
//  BooksViewModel.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import Combine

// sourcery: AutoMockable
protocol BooksViewModelProtocol {
    var books: [Book] { get }
    var onBooksUpdate: ((_ insertions: [Int]) -> Void)? { get set }
    
    /// - Note: Should be called upon a new search.
    func search(query: String)
    /// - Note: Should be called when there is already a query.
    func fetchNextPage()
}

final class BooksViewModel: BooksViewModelProtocol {
    
    // MARK: - Properties
    
    // MARK: Public
    
    private(set) var books = [Book]()
    var onBooksUpdate: ((_ insertions: [Int]) -> Void)?
    
    // MARK: Private
    
    private let networkRouter: BooksNetworkRouting
    private var query: String?
    private var nextPageTokenString: String?
    private var cancellable: AnyCancellable?
    
    // MARK: - Life Cycle
    
    init(networkRouter: BooksNetworkRouting = BooksNetworkRouter()) {
        self.networkRouter = networkRouter
    }
    
}

// MARK: - Search & Fetch

extension BooksViewModel {
    
    /// - Note: Should be called upon a new search.
    func search(query: String) {
        // Clear previous search data.
        self.query = query
        nextPageTokenString = nil
        cancellable?.cancel()
        
        // Search.
        cancellable = networkRouter.search(query: query, pageToken: nil).sink { [weak self] _ in
            self?.cancellable = nil
        } receiveValue: { [weak self] response in
            self?.update(response: response)
        }
    }
    
    /// - Note: Should be called when there is already a query.
    func fetchNextPage() {
        // Check user already has a query.
        guard let query = query else { return }
        
        cancellable?.cancel()
        
        cancellable = networkRouter.search(query: query, pageToken: nextPageTokenString).sink { [weak self] _ in
            self?.cancellable = nil
        } receiveValue: { [weak self] response in
            self?.update(response: response)
        }
    }
    
    private func update(response: BooksNetworkRouter.Search.Response) {
        nextPageTokenString = response.nextPageToken
        if response.books.isEmpty { return }
        
        // Configure inserted indexes and notify using closure.
        let currentLastIndex = books.count
        books.append(contentsOf: response.books)
        let updatedLastIndex = books.count - 1
        let indexes = Array(currentLastIndex...updatedLastIndex)
        onBooksUpdate?(indexes)
    }
    
}
