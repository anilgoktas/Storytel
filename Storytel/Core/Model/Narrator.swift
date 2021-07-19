//
//  Narrator.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import SwiftyJSON

struct Narrator: Identifiable {
    
    // MARK: - Properties
    
    let id: Int
    let name: String
    
    // MARK: - Life Cycle
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
    
    var dictionaryValue: [String: Any] {
        ["id": id, "name": name]
    }
    
}
