//
//  NetworkOperation.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation

public protocol NetworkOperation {
    associatedtype Request: NetworkRequest
    associatedtype Response: NetworkResponse
}
