//
//  BooksRepository.swift
//  BooksRepository
//
//  Created by Anil Goktas on 7/23/21.
//

import Foundation
import Combine

#warning("Should we store query string and rename this into BooksSearchRepository?")

// sourcery: AutoMockable
protocol BooksRepository {
    var books: [Book] { get }
    var onBooksUpdate: ((_ insertions: [Int]) -> Void)? { get set }
    
//    func fetchNextPage()
}

final class BooksRepositoryObject: BooksRepository {
    
    // MARK: - Properties
    
    // MARK: Public
    
    private(set) var books = [Book]()
    var onBooksUpdate: ((_ insertions: [Int]) -> Void)?
    
    // MARK: Private
    
    private let networkRouter: BooksNetworkRouting
    private var nextPageTokenString: String?
    private var cancellable: AnyCancellable?
    
    // MARK: - Life Cycle
    
    init(networkRouter: BooksNetworkRouting = BooksNetworkRouter()) {
        self.networkRouter = networkRouter
    }
    
}
