//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Linked List Node Protocol.
 */
public protocol DSLinkedListNodeProtocol: class {
    
    /// Generic Data Type.
    associatedtype DataType
    
    /// Previous node of current node.
    var previous: Self? { get set }
    /// Next node of current node.
    var next: Self? { get set }
    
    /// Specific data of the node.
    var data: DataType { get set }
    
    /**
     Create a node.
     
     - Parameter data: Data of the node.
     */
    init(data: DataType)
    
}
