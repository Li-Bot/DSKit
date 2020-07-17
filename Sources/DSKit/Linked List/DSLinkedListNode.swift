//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Linked List Node.
 */
public final class DSLinkedListNode<DataType>: DSLinkedListNodeProtocol {
    
    public weak var previous: DSLinkedListNode<DataType>?
    public var next: DSLinkedListNode<DataType>?
    
    public var data: DataType
    
    public convenience init(data: DataType) {
        self.init(data: data, previous: nil, next: nil)
    }
    
    /**
     Create a node.
     
     - Parameter data: Data of the node.
     - Parameter previous: Previous node of the new node.
     - Parameter next: Next node of the new node.
     */
    public init(data: DataType, previous: DSLinkedListNode<DataType>? = nil, next: DSLinkedListNode<DataType>? = nil) {
        self.data = data
        self.previous = previous
        self.next = next
    }
    
}
