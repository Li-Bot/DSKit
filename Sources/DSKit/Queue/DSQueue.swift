//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Queue Data Structure.
 */
public final class DSQueue<DataType>: DSQueueProtocol {
    
    public var isEmpty: Bool {
        linkedList.isEmpty
    }
    
    /// Queue list.
    private let linkedList = DSLinkedList<DSLinkedListNode<DataType>>()
    
    public func enqueue(_ data: DataType) {
        linkedList.append(data: data)
    }
    
    public func dequeue() -> DataType? {
        guard let node = linkedList.head else {
            return nil
        }
        linkedList.remove(node: node)
        return node.data
    }
    
}
