//
//  BookTableViewCellSnapshotTests.swift
//  StorytelSnapshotTests
//
//  Created by Anil Goktas on 7/19/21.
//

@testable import Storytel
import UIKit

/// - Note: Tested using `iPhone 12 Pro` simulator.
final class BookTableViewCellSnapshotTests: BaseSnapshotTestCase {
    
    // MARK: - Factory
    
    func makeSubject(book: Book) -> BookTableViewCell {
        let subject = R.nib.bookTableViewCell.firstView(owner: nil)!
        subject.configure(book: book)
        subject.frame.size = subject.systemLayoutSizeFittingToScreenWidthAndCompressedHeight()
        return subject
    }
    
}

// MARK: - Tests

extension BookTableViewCellSnapshotTests {
    
    func test_singleAuthor_singleNarrator() {
        let subject = makeSubject(book: .harryPotterAndThePhilosophersStone())
        verify(subject)
    }
    
    func test_twoAuthors_twoNarrators() {
        let subject = makeSubject(book: .harryPottcastFlammernesPokal())
        verify(subject)
    }
    
}
