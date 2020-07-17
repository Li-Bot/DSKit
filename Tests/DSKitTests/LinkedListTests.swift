//
//  LinkedListTests.swift
//  DSKit
//
//  Created by Libor Polehna on 17/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest

class LinkedListTests: XCTestCase {
    
    private var linkedList: DSLinkedList<DSLinkedListNode<Int>>!
    
    override func setUp() {
        super.setUp()
        linkedList = DSLinkedList()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppendData() {
        linkedList.append(data: 42)
        XCTAssert(linkedList.isEmpty == false)
    }
    
    func testAppendNode() {
        linkedList.append(node: DSLinkedListNode(data: 42))
        XCTAssert(linkedList.isEmpty == false)
    }
    
    func testGet() {
        linkedList.append(data: 42)
        let value = linkedList[0]
        XCTAssert(value != nil)
        XCTAssert(value?.data == 42)
    }
    
    func testRemoveAtIndex() {
        linkedList.append(data: 42)
        linkedList.remove(at: 0)
        XCTAssert(linkedList.isEmpty == true)
    }
    
    func testRemoveNode() {
        linkedList.append(data: 42)
        let node = linkedList[0]!
        linkedList.remove(node: node)
        XCTAssert(linkedList.isEmpty == true)
    }
    
    func testRemoveAll() {
        linkedList.append(data: 42)
        linkedList.append(data: 41)
        linkedList.removeAll()
        XCTAssert(linkedList.isEmpty == true)
    }

}
