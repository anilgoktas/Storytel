//
//  Environment.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation

struct Environment {
    
    // MARK: - Stored Properties
    
    var date: () -> Date = Date.init
    var logger: Logging = Logger()
    var network: NetworkSession = AlamofireNetworkSession(session: .default)
    
    // MARK: - Computed Properties
    
    var isUnitTesting: Bool { ProcessInfo.processInfo.arguments.contains("-UNITTEST") }
    
}

var Current = Environment() {
    didSet {
        if !Current.isUnitTesting {
            fatalError("Only test targets can modify the current environment")
        }
    }
}
