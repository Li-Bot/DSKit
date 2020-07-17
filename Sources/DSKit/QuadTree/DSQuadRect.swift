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
 QuadRect Data Structure for representing a Quadrant in a QuadTree.
 */
public final class DSQuadRect {
    
    /// Top-left subquadrect.
    internal lazy var topLeft: DSQuadRect = DSQuadRect(origin: origin, end: center)
    /// Top-right subquadrect.
    internal lazy var topRight: DSQuadRect = DSQuadRect(origin: CGPoint(x: center.x, y: origin.y), end: CGPoint(x: end.x, y: center.y))
    /// Bottom-left subquadrect.
    internal lazy var bottomLeft: DSQuadRect = DSQuadRect(origin: CGPoint(x: origin.x, y: center.y), end: CGPoint(x: center.x, y: end.y))
    /// Bottom-right subquadrect.
    internal lazy var bottomRight: DSQuadRect = DSQuadRect(origin: center, end: end)
    
    /// Center of the quadrect.
    public lazy var center = CGPoint(x: (origin.x + end.x) / 2.0, y: (origin.y + end.y) / 2.0)
    /// Size of the quadrect.
    public lazy var size = CGSize(width: end.x - origin.x, height: end.y - origin.y)
    
    /// Frame of the quadrect.
    public lazy var frame = CGRect(origin: origin, size: size)
    
    /// Top-left point of the quadrect.
    public let origin: CGPoint
    /// Bottom-right point of the quadrect.
    public let end: CGPoint
    
    /**
     Create a new QuadRect.
     
     - Parameter origin: Top-left point of the quadrect.
     - Parameter end: Bottom-right point of the quadrect.
     */
    public init(origin: CGPoint, end: CGPoint) {
        self.origin = origin
        self.end = end
    }
    
    /**
     Check if the given `point` lies inside of the quadrect.
     
     - Parameter point: Point to be checked.
     
     - Returns: Yes, if the quadrect contains given `point`, otherwise no.
     */
    func contains(point: CGPoint) -> Bool {
        point.x >= origin.x &&
        point.x < end.x &&
        point.y >= origin.y &&
        point.y < end.y
    }
    
    /**
     Check if the given `circle` intersects the quadrect.
    
     - Parameter circle: Circle to be checked.
    
     - Returns: Yes, if the quadrect intersects given `circle`, otherwise no.
    */
    func contains(circle: DSCircle) -> Bool {
        frame.contains(circle.frame)
    }
    
}
