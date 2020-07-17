//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation
import CoreGraphics

#if os(iOS)
import UIKit
public typealias Image = UIImage
public typealias Color = UIColor
#elseif os(macOS)
import Cocoa
public typealias Image = NSImage
public typealias Color = NSColor
#endif


/**
 Render a quadtree to an image.
 */
public final class QuadTreeRenderer {
    
    /// Line width, which defines a quadrant.
    public let lineWidth: CGFloat
    /// Line color, which defines a quadrant.
    public let lineColor: Color
    /// A node of quadtree is represented as a circle. This property defines diameter of the circle.
    public let nodeDiameter: CGFloat
    /// A node of quadtree is represented as a circle. This property defines color of the circle.
    public let nodeColor: Color
    /// Color of highlighted area.
    public let highlightedColor: Color
    
    /// Radius of a node.
    private lazy var radius = nodeDiameter / 2.0
    
    /**
     Create a tree renderer.
     
     - Parameter lineWidth: Line width, which defines a quadrant.
     - Parameter lineColor: Line color, which defines a quadrant.
     - Parameter nodeDiameter: A node of quadtree is represented as a circle. This property defines diameter of the circle.
     - Parameter highlightedColor: Color of highlighted area.
     - Parameter nodeColor: A node of quadtree is represented as a circle. This property defines color of the circle.
     */
    public init(lineWidth: CGFloat = 1.0, lineColor: Color = .black, nodeDiameter: CGFloat = 5.0, nodeColor: Color = .blue, highlightedColor: Color = Color.red.withAlphaComponent(0.3)) {
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.nodeDiameter = nodeDiameter
        self.nodeColor = nodeColor
        self.highlightedColor = highlightedColor
    }
    
    /**
     Draw a given `tree`.
     
     - Parameter tree: A given tree to be drawn.
     - Parameter highlight: Highlight quadrants that lie inside of a given circle.
     
     - Returns: Image that represents given `tree`.
     */
    public func draw<NodeDataType>(tree: QuadTree<NodeDataType>, highlight: DSCircle? = nil) -> Image {
#if os(iOS)
        UIGraphicsBeginImageContextWithOptions(tree.root.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
#elseif os(macOS)
        let image = NSImage.init(size: tree.root.bounds.size)

        let rep = NSBitmapImageRep.init(bitmapDataPlanes: nil,
            pixelsWide: Int(tree.root.bounds.size.width),
            pixelsHigh: Int(tree.root.bounds.size.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: NSColorSpaceName.calibratedRGB,
            bytesPerRow: 0,
            bitsPerPixel: 0)

        image.addRepresentation(rep!)
        image.lockFocus()
        
        let context = NSGraphicsContext.current!.cgContext
        context.clear(NSMakeRect(0, 0, tree.root.bounds.size.width, tree.root.bounds.size.height))
#endif
        
        // Outer Frame
        let halfLineWidth = lineWidth / 2.0
        context.move(to: CGPoint(x: tree.root.bounds.origin.x + halfLineWidth, y: tree.root.bounds.origin.y + halfLineWidth))
        context.addLine(to: CGPoint(x: tree.root.bounds.end.x - halfLineWidth, y: halfLineWidth + tree.root.bounds.origin.y))
        context.addLine(to: CGPoint(x: tree.root.bounds.end.x - halfLineWidth, y: tree.root.bounds.end.y - halfLineWidth))
        context.addLine(to: CGPoint(x: tree.root.bounds.origin.x + halfLineWidth, y: tree.root.bounds.end.y - halfLineWidth))
        context.closePath()
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(lineWidth)
        context.strokePath()
        
        // Inner Frame
        var quadrants = [tree.root]
        while true {
            if quadrants.count == 0 {
                break
            }
            let quadrant = quadrants.removeLast()
            
            if quadrant.nodes.isEmpty {
                var localQuadrants = [Quadrant<NodeDataType>]()
                if let quadrant = quadrant.topLeft { localQuadrants.append(quadrant) }
                if let quadrant = quadrant.topRight { localQuadrants.append(quadrant) }
                if let quadrant = quadrant.bottomLeft { localQuadrants.append(quadrant) }
                if let quadrant = quadrant.bottomRight { localQuadrants.append(quadrant) }
                
                if !localQuadrants.isEmpty {
                    quadrants.append(contentsOf: localQuadrants)
                    context.move(to: CGPoint(x: quadrant.bounds.origin.x, y: quadrant.bounds.center.y))
                    context.addLine(to: CGPoint(x: quadrant.bounds.end.x, y: quadrant.bounds.center.y))
                    context.move(to: CGPoint(x: quadrant.bounds.center.x, y: quadrant.bounds.origin.y))
                    context.addLine(to: CGPoint(x: quadrant.bounds.center.x, y: quadrant.bounds.end.y))
                    context.strokePath()
                }
            } else {
                if let highlight = highlight, quadrant.bounds.contains(circle: highlight) {
                    context.addRect(quadrant.bounds.frame)
                    context.setFillColor(highlightedColor.cgColor)
                    context.fillPath()
                }
                
                for node in quadrant.nodes {
                    context.addEllipse(in: CGRect(origin: CGPoint(x: node.position.x - radius, y: node.position.y - radius), size: CGSize(width: radius, height: radius)))
                }
                context.setFillColor(nodeColor.cgColor)
                context.fillPath()
            }
            
        }
        
        // Highlighted area
        if let highlight = highlight {
            context.addEllipse(in: CGRect(origin: CGPoint(x: highlight.center.x - highlight.radius, y: highlight.center.y - highlight.radius), size: CGSize(width: highlight.radius * 2.0, height: highlight.radius * 2.0)))
        }
        
        
#if os(iOS)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
#elseif os(macOS)
        image.unlockFocus()
        return image
#endif
    }
    
}
