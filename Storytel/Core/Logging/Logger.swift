//
//  Logger.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import os.log

final class Logger: Logging {
    
    // MARK: - Default Loggers
    
    /// Defines which loggers to include.
    private static func loggers() -> [Logging] {
        [OSLogger()]
    }
    
    // MARK: - Properties
    
    private let loggers: [Logging]
    
    // MARK: - Life Cycle
    
    init(loggers: [Logging] = loggers()) {
        self.loggers = loggers
    }
    
    // MARK: - Logging
    
    func log(_ message: String, log: OSLog, type: OSLogType) {
        loggers.forEach {
            $0.log(message, log: log, type: type)
        }
    }
    
}
