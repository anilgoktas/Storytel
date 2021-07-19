//
//  NetworkResponse.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import SwiftyJSON

public protocol NetworkResponse {
    init(json: JSON) throws
}
