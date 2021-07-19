//
//  Book.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import Foundation
import SwiftyJSON

struct Book: Identifiable {
    
    // MARK: - Properties
    
    let id: Int
    let title: String
    let coverImageURLString: String
    let authors: [Author]
    let narrators: [Narrator]
    
    var coverImageURL: URL? { URL(string: coverImageURLString) }
    
    // MARK: - Life Cycle
    
    init(
        id: Int,
        title: String,
        coverImageURLString: String,
        authors: [Author],
        narrators: [Narrator]
    ) {
        self.id = id
        self.title = title
        self.coverImageURLString = coverImageURLString
        self.authors = authors
        self.narrators = narrators
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        coverImageURLString = json["cover"]["url"].stringValue
        authors = json["authors"].arrayValue.map { Author(json: $0) }
        narrators = json["narrators"].arrayValue.map { Narrator(json: $0) }
    }
    
    var dictionaryValue: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = id
        dict["title"] = title
        dict["cover"] = ["url": coverImageURLString]
        dict["authors"] = authors.map { $0.dictionaryValue }
        dict["narrators"] = narrators.map { $0.dictionaryValue }
        return dict
    }
    
}
