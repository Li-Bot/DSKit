//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry


/**
 QuadTree Data Structure.
 */
public final class QuadTree<NodeDataType> {
    
    /// The main quadrant of the tree.
    internal let root: Quadrant<NodeDataType>
    /// Maxium number of nodes in a quadrant.
    public let maxNodes: Int?
    /// Maximum depth of the quadtree.
    public let maxDepth: Int?
    
    /**
     Create a QuadTree.
     
     - Parameter rect: Main rect of first quadrant of the quadtree.
     - Parameter maxNodes: Maxium number of nodes in a quadrant.
     - Parameter maxDepth: Maximum depth of the quadtree.
     */
    public init(rect: DSQuadRect, maxNodes: Int? = nil, maxDepth: Int? = nil) {
        self.root = Quadrant(bounds: rect)
        self.maxDepth = maxDepth
        self.maxNodes = maxNodes
    }
    
    /**
     Insert the given `node` into the quadtree.
     
     - Parameter node: A node to be inserted.
     
     - Returns: Yes, if node has been inserted, otherwise, when you have defined `maxNodes` and `maxDepth` and the quadtree is saturated, then no.
     */
    public func insert(node: QuadTreeNode<NodeDataType>) -> Bool {
        return insert(node: node, in: root, depth: 0)
    }
    
    /**
     Find a node at given `position`.
     
     - Parameter position: Position of node.
     
     - Returns: `QuadTreeNode<NodeDataType>`, if a node exists at given `position`, otherwise nil.
     */
    public func search(at position: CGPoint) -> QuadTreeNode<NodeDataType>? {
        var quadrant = root
        if !quadrant.bounds.contains(point: position) {
            return nil
        }
        while true {
            guard let currentQuadrant = quadrant.getQuadrant(at: position) else {
                break
            }
            quadrant = currentQuadrant
        }
        for node in quadrant.nodes {
            if node.position == position {
                return node
            }
        }
        return nil
    }
    
    /**
     Find all nodes at given `position`.
    
     - Parameter position: Position of node.
    
     - Returns: `QuadTreeNode<NodeDataType>`, if a node exists at given `position`, otherwise nil.
    */
    public func search(at circle: DSCircle) -> [QuadTreeNode<NodeDataType>] {
        let currentQuadrant = root
        let quadrants = DSQueue<Quadrant<NodeDataType>>()
        quadrants.enqueue(currentQuadrant)
        var nodes = [QuadTreeNode<NodeDataType>]()
        if !currentQuadrant.bounds.contains(circle: circle) {
            return []
        }
        while true {
            guard let currentQuadrant = quadrants.dequeue() else {
                break
            }
            let localQuadrants = currentQuadrant.getQuadrants(at: circle)
            if let localQuadrants = localQuadrants, !localQuadrants.isEmpty {
                for quadrant in localQuadrants {
                    quadrants.enqueue(quadrant)
                }
            } else {
                if currentQuadrant.nodes.isEmpty {
                    continue
                }
                for node in currentQuadrant.nodes {
                    if circle.contains(point: node.position) {
                        nodes.append(node)
                    }
                }
            }
        }
        return nodes
    }
    
    /**
     Find all nodes at given `position` in given `quadrant`. Recursive version of the search method.
    
     - Parameter position: Position of node.
     - Parameter quadrant: Qaudrant to be searched.
    
     - Returns: `QuadTreeNode<NodeDataType>`, if a node exists at given `position`, otherwise nil.
    */
    internal func searchR(at circle: DSCircle, quadrant: Quadrant<NodeDataType>? = nil) -> [QuadTreeNode<NodeDataType>]? {
        let currentQuadrant = quadrant ?? root
        if !currentQuadrant.bounds.contains(circle: circle) {
            return nil
        }
        var nodes = [QuadTreeNode<NodeDataType>]()
        if let subquadrant = currentQuadrant.topLeft, subquadrant.bounds.contains(circle: circle) {
            if let subnodes = searchR(at: circle, quadrant: subquadrant) {
                nodes.append(contentsOf: subnodes)
            }
        }
        if let subquadrant = currentQuadrant.topRight, subquadrant.bounds.contains(circle: circle) {
            if let subnodes = searchR(at: circle, quadrant: subquadrant) {
                nodes.append(contentsOf: subnodes)
            }
        }
        if let subquadrant = currentQuadrant.bottomRight, subquadrant.bounds.contains(circle: circle) {
            if let subnodes = searchR(at: circle, quadrant: subquadrant) {
                nodes.append(contentsOf: subnodes)
            }
        }
        if let subquadrant = currentQuadrant.bottomLeft, subquadrant.bounds.contains(circle: circle) {
            if let subnodes = searchR(at: circle, quadrant: subquadrant) {
                nodes.append(contentsOf: subnodes)
            }
        }
        
        for node in currentQuadrant.nodes {
            if circle.contains(point: node.position) {
                nodes.append(node)
            }
        }
        
        return nodes.isEmpty ? nil : nodes
    }
    
    /**
     Insert the given `node` into given `quadrant`.
    
     - Parameter node: A node to be inserted.
     - Parameter quadrant: Qaudrant where the given `node` will be inserted.
     - Parameter depth: Current depth in the quadtree of given `quadrant`.
    
     - Returns: Yes, if node has been inserted, otherwise, when you have defined `maxNodes` and `maxDepth` and the quadtree is saturated, then no.
    */
    private func insert(node: QuadTreeNode<NodeDataType>, in quadrant: Quadrant<NodeDataType>, depth: Int) -> Bool {
        var quadrant: Quadrant = quadrant
        if !quadrant.bounds.contains(point: node.position) {
            return false
        }
        let maxDepth = self.maxDepth ?? Int.max
        let maxPoints = self.maxNodes ?? Int.max
        var depth = depth
        while true {
            guard let currentQuadrant = quadrant.getQuadrant(at: node.position) else {
                break
            }
            quadrant = currentQuadrant
            depth += 1
        }
        
        quadrant.nodes.append(node)
        if quadrant.nodes.count > maxPoints {
            if depth > maxDepth {
                return false
            }
            let result = split(quadrant: quadrant, depth: depth)
            if !result {
                _ = quadrant.nodes.removeLast()
            }
            return result
        }
        return true
    }
    
    /**
     Split the given `quadrant` to four subquadrants.
     
     - Parameter quadrant: Quadrant to be splitted.
     - Parameter depth: Current depth in the quadtree of given `quadrant`.
     
     - Returns: Yes, if node has been inserted, otherwise, when you have defined `maxNodes` and `maxDepth` and the quadtree is saturated, then no.
     */
    private func split(quadrant: Quadrant<NodeDataType>, depth: Int) -> Bool {
        quadrant.topLeft = Quadrant(bounds: quadrant.bounds.topLeft)
        quadrant.topRight = Quadrant(bounds: quadrant.bounds.topRight)
        quadrant.bottomLeft = Quadrant(bounds: quadrant.bounds.bottomLeft)
        quadrant.bottomRight = Quadrant(bounds: quadrant.bounds.bottomRight)
        
        return rearrange(quadrant: quadrant, depth: depth)
    }
    
    /**
     Rearrange nodes inside the given `quadrant` to four subquadrants.
    
     - Parameter quadrant: Quadrant to be rearrange.
     - Parameter depth: Current depth in the quadtree of given `quadrant`.
    
     - Returns: Yes, if node has been inserted, otherwise, when you have defined `maxNodes` and `maxDepth` and the quadtree is saturated, then no.
    */
    private func rearrange(quadrant: Quadrant<NodeDataType>, depth: Int) -> Bool {
        var result = true
        for node in quadrant.nodes {
            let subquadrant = quadrant.getQuadrant(at: node.position)!
            //subquadrant.points.append(point)
            result = result && insert(node: node, in: subquadrant, depth: depth + 1)
        }
        if result {
            quadrant.nodes = []
        }
        return result
    }
    
}
