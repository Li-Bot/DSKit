//
//  QuadTreeTests.swift
//  DSKit
//
//  Created by Libor Polehna on 17/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest

class QuadTreeTests: XCTestCase {

    private var quadTree: DSQuadTree<Int>!
    
    override func setUp() {
        super.setUp()
        let rect = DSQuadRect(origin:.zero, end: CGPoint(x: 100.0, y: 100.0))
        quadTree = DSQuadTree(rect: rect)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsert() {
        let result = quadTree.insert(node: DSQuadTreeNode(position: CGPoint(x: 10.0, y: 10.0), data: 1))
        XCTAssert(result == true)
    }
    
    func testSearchNode() {
        _ = quadTree.insert(node: DSQuadTreeNode(position: CGPoint(x: 40.0, y: 40.0), data: 1))
        let foundNode = quadTree.search(at: CGPoint(x: 40.0, y: 40.0))
        XCTAssert(foundNode?.data == 1)
    }
    
    func testSearchNodes() {
        _ = quadTree.insert(node: DSQuadTreeNode(position: CGPoint(x: 40.0, y: 40.0), data: 1))
        _ = quadTree.insert(node: DSQuadTreeNode(position: CGPoint(x: 60.0, y: 60.0), data: 1))
        let foundNodes = quadTree.search(at: DSCircle(center: CGPoint(x: 50.0, y: 50.0), radius: 25.0))
        XCTAssert(foundNodes.count == 2)
    }

}
