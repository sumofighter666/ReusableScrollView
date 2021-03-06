//
//  ScrollEngine_6_Tests.swift
//  ScrollEngineTests
//
//  Created by sumofighter666 on 23.04.18.
//  Copyright © 2018 sumofighter666. All rights reserved.
//

import XCTest
@testable import ReusableScrollView

/*
 Test configuration:
 absolute index: 7
 number of views: 13
 
 Test includes:
 1. Initialization
 2. Request next
 3. Request previous
 
 Test Expectation
 1. Number of models: 5
 2. Current model: defined
 3. Current model absolute index: 7
 4. Current model relative index: RelativeIndex.current
 5. Appended index: 10
 6. Appended index: 4
 7. Model view position y: 0.0
 
 */

class ScrollEngine_7_Tests : ScrollEngineBase {
    
    let expectedNumberOfModels          = 5
    let expectedRelativeIndices         = [-2,-1,0,1,2]
    let expectedCurrentRelativeIndex    = RelativeIndex.current
    let expectedCurrentXPosition        = CGFloat(700)
    let expectedNextXPosition           = CGFloat(800)
    let expectedPreviousXPosition       = CGFloat(600)
    let expectedYPosition               = CGFloat(0)
    let expectedApendedNextIndex        = 10
    let expectedApendedPreviousIndex    = 4
    
    override func setUp() {
        super.setUp()
        
        absoluteIndex                = test_7_config.absoluteIndex
        viewsCount                   = test_7_config.numberOfViews
        
        self.prepare()
    }
    
    func test_01_initialization() {
        
        // Test number of models returned
        XCTAssertEqual(countOfModels, expectedNumberOfModels, "\nTest Failed: Expected `\(expectedNumberOfModels)` scroll view models but given `\(countOfModels)`\n")
        
        // Test model marked `current` was found
        XCTAssertNotNil(currentModel, "\nTest Failed: Model marked `current` not found\n")
        
        // Test absolute index for current model
        XCTAssertEqual(currentModel?.absoluteIndex, absoluteIndex, "\nTest Failed: Expected `\(absoluteIndex)` absolute index but given different\n")
        
        // Test x, y positions of the current view
        XCTAssertEqual(currentModel?.position.x, expectedCurrentXPosition, "\nTest Failed: Expected `\(expectedCurrentXPosition)` x position of the current view, but given `\(currentModel?.position.x ?? CGFloat(-9999.0))`\n")
        XCTAssertEqual(currentModel?.position.y, expectedYPosition, "\nTest Failed: Expected `\(expectedYPosition)` y position of the current view, but given `\(currentModel?.position.y ?? CGFloat(-9999.0))`\n")
        
        // Test relative indices
        
        var i = 0
        
        self.models.forEach { viewModel in
            XCTAssertEqual(viewModel.relativeIndex.rawValue, expectedRelativeIndices[i],
                           "\nTest Failed: Expected \(expectedRelativeIndices[i]) relative index but given \(viewModel.relativeIndex.rawValue)\n")
            i += 1
        }
    }
    
    func test_02_requestNext() {
        
        self.next()
        
        // Test model marked `current` was found
        XCTAssertNotNil(currentModel, "\nTest Failed: Model marked `current` not found\n")
        
        // Test scrolling direction is set up
        XCTAssertNotNil(scrollingDirection, "\nTest Failed: Scrolling direction not defined\n")
        
        // Test appended index
        XCTAssertEqual(appendedIndex, expectedApendedNextIndex, "\nTest Failed: appendedIndex should be `\(expectedApendedNextIndex)` but given \(appendedIndex ?? -9999)\n")
        
    }
    
    func test_03_requestPrevious() {
        
        self.previous()
        
        // Test model marked `current` was found
        XCTAssertNotNil(currentModel, "\nTest Failed: Model marked `current` not found\n")
        
        // Test scrolling direction is set up
        XCTAssertNotNil(scrollingDirection, "\nTest Failed: Scrolling direction not defined\n")
        
        // Test appended index
        XCTAssertEqual(appendedIndex, expectedApendedPreviousIndex, "\nTest Failed: appendedIndex should be `\(expectedApendedPreviousIndex)` but given \(appendedIndex ?? -9999)\n")
    }
    
}
