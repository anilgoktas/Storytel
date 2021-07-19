//
//  Mocker.swift
//  StorytelSnapshotTests
//
//  Created by Anil Goktas on 7/19/21.
//

@testable import Storytel
import Foundation

final class Mocker {
    
    // MARK: - Properties
    
    let logger = LoggingMock()
    let network = NetworkSessionMock()
    
    func inject() {
        Current.date = Date.init
        Current.logger = logger
        Current.network = network
    }
    
}

/// Syntactic Sugar for Mocker owner classes
protocol MockerOwner: AnyObject {
    var mocker: Mocker { get }
}

extension MockerOwner {
    
    var logger: LoggingMock { mocker.logger }
    var network: NetworkSessionMock { mocker.network }
    
}
