//
//  Config.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation

enum Config {

    // MARK: - API

    enum Endpoint {
        #if DEBUG
        static let urlString = "https://api.storytel.net"
        #elseif STAGING
        static let urlString = "https://api.storytel.net"
        #else
        static let urlString = "https://api.storytel.net"
        #endif
        static let baseURL = URL(string: urlString)!
    }
    
}
