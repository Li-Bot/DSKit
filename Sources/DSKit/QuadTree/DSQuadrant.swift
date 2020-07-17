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
 Quadrant Data Structure for a QuadTree.
 */
internal final class DSQuadrant<NodeDataType> {
    
    /// Top-left subquadrant.
    internal var topLeft: DSQuadrant<NodeDataType>?
    /// Top-right subquadrant.
    internal var topRight: DSQuadrant<NodeDataType>?
    /// Bottom-left subquadrant.
    internal var bottomRight: DSQuadrant<NodeDataType>?
    /// Bottom-right subquadrant.
    internal var bottomLeft: DSQuadrant<NodeDataType>?
    
    /// Data Nodes.
    internal var nodes = [DSQuadTreeNode<NodeDataType>]()
    
    /// Bounds of the quadrant.
    internal let bounds: DSQuadRect
    
    /**
     Create a new Quadrant.
     
     - Parameter bounds: Bounds of a new quadrant.
     - Parameter node: Data Node.
     */
    internal init(bounds: DSQuadRect, node: DSQuadTreeNode<NodeDataType>? = nil) {
        self.bounds = bounds
        if let node = node {
            nodes.append(node)
        }
    }
    
    /**
     Get quadrant at given `point`.
     
     - Parameter point: Position to be checked.
     
     - Returns: `Quadrant<NodeDataType>`, if any subquadrant of current quadrant contains given `point`, otherwise nil.
     */
    internal func getQuadrant(at point: CGPoint) -> DSQuadrant<NodeDataType>? {
        if !bounds.contains(point: point) {
            return nil
        }
        if point.x <= bounds.center.x {
            if point.y <= bounds.center.y {
                return topLeft
            }
            return bottomLeft
        }
        if point.y <= bounds.center.y {
            return topRight
        }
        return bottomRight
    }
    
    /**
     Get quadrants that intersect given `cirle`.
    
     - Parameter cirle: Circle to be checked.
    
     - Returns: Array of `Quadrant<NodeDataType>`, that intersect given `circle`, otherwise nil.
    */
    internal func getQuadrants(at cirle: DSCircle) -> [DSQuadrant<NodeDataType>]? {
        if !bounds.contains(circle: cirle) {
            return nil
        }
        let isTopLeft = topLeft?.bounds.contains(circle: cirle) ?? false
        let isTopRight = topRight?.bounds.contains(circle: cirle) ?? false
        let isBottomRight = bottomRight?.bounds.contains(circle: cirle) ?? false
        let isBottomLeft = bottomLeft?.bounds.contains(circle: cirle) ?? false
        /*var quadrants = Array<Quadrant<NodeDataType>>()
        
        if isTopLeft {
            quadrants.append(topLeft!)
        }
        if isTopRight {
            quadrants.append(topRight!)
        }
        if isBottomRight {
            quadrants.append(bottomRight!)
        }
        if isBottomLeft {
            quadrants.append(bottomLeft!)
        }
        //return quadrants*/
        
        if !isTopLeft && !isTopRight && !isBottomRight && isBottomLeft {
            return [bottomLeft!]
        } else if !isTopLeft && !isTopRight && isBottomRight && !isBottomLeft {
            return [bottomRight!]
        } else if !isTopLeft && !isTopRight && isBottomRight && isBottomLeft {
            return [bottomRight!, bottomLeft!]
        } else if !isTopLeft && isTopRight && !isBottomRight && !isBottomLeft {
            return [topRight!]
        } else if !isTopLeft && isTopRight && !isBottomRight && isBottomLeft {
            return [topRight!, bottomLeft!]
        } else if !isTopLeft && isTopRight && isBottomRight && !isBottomLeft {
            return [topRight!, bottomRight!]
        } else if !isTopLeft && isTopRight && isBottomRight && isBottomLeft {
            return [topRight!, bottomRight!, bottomLeft!]
        } else if isTopLeft && !isTopRight && !isBottomRight && !isBottomLeft {
            return [topLeft!]
        } else if isTopLeft && !isTopRight && !isBottomRight && isBottomLeft {
            return [topLeft!, bottomLeft!]
        } else if isTopLeft && !isTopRight && isBottomRight && !isBottomLeft {
            return [topLeft!, bottomRight!]
        } else if isTopLeft && !isTopRight && isBottomRight && isBottomLeft {
            return [topLeft!, bottomRight!, bottomLeft!]
        } else if isTopLeft && isTopRight && !isBottomRight && !isBottomLeft {
            return [topLeft!, topRight!]
        } else if isTopLeft && isTopRight && isBottomRight && !isBottomLeft {
            return [topLeft!, topRight!, bottomRight!]
        } else if isTopLeft && isTopRight && isBottomRight && isBottomLeft {
            return [topLeft!, topRight!, bottomRight!, bottomLeft!]
        }
        return nil
    }
    
}
