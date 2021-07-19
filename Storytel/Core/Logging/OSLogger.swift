//
//  OSLogger.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import os.log

final class OSLogger: Logging {
    
    func log(_ message: String, log: OSLog, type: OSLogType) {
        #if DEBUG || STAGING
        os_log("%{public}@", log: log, type: type, message)
        #else
        os_log("%{private}@", log: log, type: type, message)
        #endif
    }
    
}
