//
//  Book+Extensions.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

@testable import Storytel

extension Book {
    
    static func harryPotterAndThePhilosophersStone() -> Book {
        Book(
            id: 117931,
            title: "Harry Potter and the Philosopher's Stone",
            coverImageURLString: "",
            authors: [.jkRowling()],
            narrators: [.stephenFry()]
        )
    }
    
    // Harry Pottcast & Flammernes pokal #10
    static func harryPottcastFlammernesPokal() -> Book {
        Book(
            id: 1258403,
            title: "Harry Pottcast & Flammernes pokal #10",
            coverImageURLString: "",
            authors: [.nannaBilleCornelsen(), .amalieDahlerupHermansen()],
            narrators: [.nannaBilleCornelsen(), .amalieDahlerupHermansen()]
        )
    }
    
}
