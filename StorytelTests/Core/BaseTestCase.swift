//
//  BaseTestCase.swift
//  StorytelTests
//
//  Created by Anil Goktas on 7/19/21.
//

@testable import Storytel
import XCTest

class BaseTestCase: XCTestCase, MockerOwner {
    
    // MARK: - Properties
    
    let mocker = Mocker()
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // `setUpWithError` is being called before `setUp`.
        // Therefore we're injecting mocker here in order to prevent overrides.
        mocker.inject()
    }
    
}
