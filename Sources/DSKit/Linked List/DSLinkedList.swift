//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Linked List Data Structure.
 */
public final class DSLinkedList<NodeType: DSLinkedListNodeProtocol>: DSLinkedListProtocol {
    
    public private(set) var head: NodeType?
    public private(set) var tail: NodeType?
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public subscript(index: Int) -> NodeType? {
        if index < 0 {
            return nil
        }
        var node = head
        var currentIndex = 0
        while currentIndex < index && node != nil {
            node = node?.next
            currentIndex += 1
        }
        return node
    }
    
    public func append(data: NodeType.DataType) {
        append(node: NodeType(data: data))
    }
    
    public func append(node: NodeType) {
        if let tail = self.tail {
            node.previous = tail
            tail.next = node
        } else {
            head = node
        }
        self.tail = node
    }
    
    public func remove(at index: Int) {
        guard let node = self[index] else {
            return
        }
        remove(node: node)
    }
    
    public func remove(node: NodeType) {
        let previous = node.previous
        let next = node.next
        
        next?.previous = previous
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        if next == nil {
            tail = previous
        }
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
}
