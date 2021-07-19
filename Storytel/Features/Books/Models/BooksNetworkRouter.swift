//
//  BooksNetworkRouter.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import SwiftyJSON
import Combine

// sourcery: AutoMockable
protocol BooksNetworkRouting {
    func search(
        query: String,
        pageToken: String?
    ) -> AnyPublisher<BooksNetworkRouter.Search.Response, Error>
}

final class BooksNetworkRouter: BooksNetworkRouting {
    
    // MARK: - Properties
    
    private var session: NetworkSession { Current.network }
    
}

// MARK: - Search

extension BooksNetworkRouter {
    
    enum Search: NetworkOperation {
        struct Request: NetworkRequest {
            let query: String
            let pageToken: String?
            
            var baseURL: URL { Config.Endpoint.baseURL.appendingPathComponent("search") }
            var method: HTTPMethod { .get }
            var parameterEncoding: NetworkParameterEncoding { NetworkParameterEncoder.url }
            
            var parameters: [String : Any]? {
                guard let pageToken = pageToken else {
                    return ["query": query]
                }
                return ["query": query, "page": pageToken]
            }
        }
        struct Response: NetworkResponse {
            let nextPageToken: String
            let books: [Book]
            
            init(nextPageToken: String, books: [Book]) {
                self.nextPageToken = nextPageToken
                self.books = books
            }
            
            init(json: JSON) throws {
                nextPageToken = json["nextPageToken"].stringValue
                books = json["items"].arrayValue.map { Book(json: $0) }
            }
        }
    }
    
    func search(
        query: String,
        pageToken: String?
    ) -> AnyPublisher<Search.Response, Error> {
        session.perform(Search.self, request: .init(query: query, pageToken: pageToken))
    }
    
}
