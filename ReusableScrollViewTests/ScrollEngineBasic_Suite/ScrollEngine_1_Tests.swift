//
//  ScrollEngineTests_Helper.swift
//  ScrollEngineTests
//
//  Created by sumofighter666 on 19.04.18.
//  Copyright © 2018 sumofighter666. All rights reserved.
//

import XCTest
@testable import ReusableScrollView

/*
 Test configuration:
    absolute index: 2
    number of views: 6
    size: 100 x 100
 
 Test includes:
    1. Initialization
    2. Request next
    3. Request previous
 
 Test Expectation
    1. Number of models: 5
    2. Current model: defined
    3. Current model absolute index: 2
    4. Current model relative index: RelativeIndex.current
    5. Appended index: 5
    6. Appended index: 0
    7. Model view position y: 0.0
 
 */


class ScrollEngine_1_Tests : ScrollEngineBase {
    
    let expectedNumberOfModels          = 5
    let expectedRelativeIndices         = [-2,-1,0,1,2]
    let expectedCurrentRelativeIndex    = RelativeIndex.current
    let expectedCurrentXPosition        = CGFloat(200)
    let expectedNextXPosition           = CGFloat(300)
    let expectedPreviousXPosition       = CGFloat(100)
    let expectedYPosition               = CGFloat(0)
    let expectedApendedNextIndex        = 5
    let expectedApendedPreviousIndex    = 0
    
    override func setUp() {
        super.setUp()
        
        absoluteIndex                = test_1_config.absoluteIndex
        viewsCount                   = test_1_config.numberOfViews
        
        self.prepare()
    }
    
    func test_01_initialization() {
        
        // Test number of models returned
        XCTAssertEqual(countOfModels, expectedNumberOfModels, "\nTest Failed: Expected `\(expectedNumberOfModels)` scroll view models, but given `\(countOfModels)`\n")
        
        // Test model marked `current` was found
        XCTAssertNotNil(currentModel, "\nTest Failed: Model marked `current` not found\n")
        
        // Test absolute index for current model
        XCTAssertEqual(currentModel?.absoluteIndex, absoluteIndex, "\nTest Failed: Expected `\(absoluteIndex)` absolute index, but given different\n")
        
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
        
        // Test absoluteIndex of current view is not the same as absoluteIndex in config
        XCTAssertEqual(currentModel?.absoluteIndex, absoluteIndex-1, "\nTest Failed: Expected `\(absoluteIndex+1)` scroll view current model index but given `\(String(describing: currentModel?.absoluteIndex))`\n")
        
        // Test scrolling direction is set up
        XCTAssertNotNil(scrollingDirection, "\nTest Failed: Scrolling direction not defined\n")
        
        // Test appended index
        XCTAssertEqual(appendedIndex, expectedApendedPreviousIndex, "\nTest Failed: appendedIndex should be `\(expectedApendedPreviousIndex)` but given \(appendedIndex ?? -9999)\n")
    }
    
}
