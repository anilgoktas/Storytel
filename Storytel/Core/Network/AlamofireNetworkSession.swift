//
//  AlamofireNetworkSession.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import SwiftyJSON
import Alamofire
import Combine

public final class AlamofireNetworkSession: NetworkSession {

    public let session: Session
    
    public init(session: Session) {
        self.session = session
    }
    
    public func perform(_ request: URLRequest) -> AnyPublisher<JSON, Error> {
        session
            .request(request)
            .publishData()
            .tryMap { try $0.result.get() }
            .tryMap { try JSON(data: $0) }
            .eraseToAnyPublisher()
    }
    
}
