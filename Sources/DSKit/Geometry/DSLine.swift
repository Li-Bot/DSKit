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
 Structure that describes coefficients of a linear equation.
 ax + bx = c
 */
public struct DSLine {
    
    /// Starting point
    public let origin: CGPoint
    /// Ending point
    public let end: CGPoint
    
    /// Coefficient A
    public let a: CGFloat
    /// Coefficient B
    public let b: CGFloat
    /// Coefficient C
    public let c: CGFloat
    
    /**
     Create a Line.
     
     - Parameter origin: Starting point
     - Parameter end: Ending point
     */
    public init(origin: CGPoint, end: CGPoint) {
        self.origin = origin
        self.end = end
        a = origin.y - end.y
        b = end.x - origin.x
        c = origin.x * end.y - end.x * origin.y
    }
    
}

