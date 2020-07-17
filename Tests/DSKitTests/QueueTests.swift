//
//  QueueTests.swift
//  DSKit
//
//  Created by Libor Polehna on 17/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest

class QueueTests: XCTestCase {
    
    private var queue: DSQueue<Int>!
    
    override func setUp() {
        super.setUp()
        queue = DSQueue()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnqueue() {
        queue.enqueue(1)
        XCTAssert(queue.isEmpty == false)
    }
    
    func testDequeue() {
        queue.enqueue(1)
        let value = queue.dequeue()
        XCTAssert(queue.isEmpty == true)
        XCTAssert(value == 1)
    }

}
