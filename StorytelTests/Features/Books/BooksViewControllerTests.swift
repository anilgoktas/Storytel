//
//  BooksViewControllerTests.swift
//  StorytelTests
//
//  Created by Anil Goktas on 7/19/21.
//

@testable import Storytel
import XCTest

final class BooksViewControllerTests: BaseTestCase {

    // MARK: - Properties
    
    let viewModel = BooksViewModelProtocolMock()
    
    // MARK: - Factory
    
    func makeSubject() -> BooksViewController {
        let subject = R.storyboard.main.booksViewController()!
        subject.viewModel = viewModel
        return subject
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_shouldCallViewModelSearch() {
        // Given
        let subject = makeSubject()
        
        // When
        subject.becomeActive()
        
        // Then
        viewModel.verify(.search(query: .value("Harry")))
    }
    
}
