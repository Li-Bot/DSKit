//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Linked List Data Structure Protocol.
 */
public protocol DSLinkedListProtocol {
    
    /// Generic type of Node.
    associatedtype NodeType: DSLinkedListNodeProtocol
    
    /// Head of the list.
    var head: NodeType? { get }
    /// Tail of the list.
    var tail: NodeType? { get }
    
    /// Yes, if the list contains any nodes, otherwise no.
    var isEmpty: Bool { get }
    
    /**
     Get node at given `index`.
     
     - Parameter index: Index of node.
     
     - Returns: `NodeType` if a node at given `index` is found, otherwise nil.
     */
    subscript(index: Int) -> NodeType? { get }
    
    /**
     Append given `data` at the end of the list.
     
     - Parameter data: Data to be appended to the list.
     */
    func append(data: NodeType.DataType)
    /**
    Append given `node` at the end of the list.
    
    - Parameter node: Node to be appended to the list.
    */
    func append(node: NodeType)
    
    /**
     Remove node at given `index`.
     */
    func remove(at index: Int)
    /**
     Remove given `node` if the list contains the `node`.
     */
    func remove(node: NodeType)
    /**
     Remove all nodes.
     */
    func removeAll()
    
}
