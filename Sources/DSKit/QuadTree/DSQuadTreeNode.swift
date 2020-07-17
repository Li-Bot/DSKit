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
 QuadTree Node.
 */
public final class QuadTreeNode<DataType> {
    
    /// Position of the node in a quadtree.
    public let position: CGPoint
    /// Data
    public let data: DataType
    
    /**
     Create a new QuadTree Node.
     
     - Parameter position: Position of the node in a quadtree.
     - Parameter data: Data.
     */
    public init(position: CGPoint, data: DataType) {
        self.position = position
        self.data = data
    }
    
}
