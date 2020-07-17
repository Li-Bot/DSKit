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
 Structure of a circle.
 */
public struct DSCircle {
    
    /// Center point
    public let center: CGPoint
    /// Radius
    public let radius: CGFloat
    /// Square representation of the circle.
    public let frame: CGRect
    
    /**
     Create a new Circle.
     
     - Parameter center: Center of a new circle.
     - Parameter raidus: Radius of a new circle.
     */
    public init(center: CGPoint, radius: CGFloat) {
        self.center = center
        self.radius = radius
        frame = CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius),
        size: CGSize(width: radius * 2.0, height: radius * 2.0))
    }
    
    /**
     Check if the given `point` lies inside of the circle.
     
     - Parameter point: Point to be tested.
     
     - Returns: Yes, if the given `point` lies inside of the circle, otherwise no.
     */
    public func contains(point: CGPoint) -> Bool {
        let dX = center.x - point.x
        let dY = center.y - point.y
        //let distance = radius * radius - centerX * centerX + centerY * centerY
        return sqrt(dX * dX + dY * dY) <= radius
    }
    
}
