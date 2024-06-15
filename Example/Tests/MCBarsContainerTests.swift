//
//  MCBarsContainerTests.swift
//  MEMComponentsTests
//
//  Created by Miller Mosquera on 18/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
@testable import MEMComponents
import XCTest

class MCBarsContainerTests: XCTestCase {
    
    var progressBarsContainer: MCBarsContainerProtocol?
    
    override func setUp() {
        progressBarsContainer = MCBarsContainer()
    }
    
    override func tearDown() {
        progressBarsContainer = nil
    }
    
    func testContainerWithThreeBarsSuccess() {
        
    }
    
    
}
