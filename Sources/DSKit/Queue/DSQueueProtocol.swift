//
//  DSQueue.swift
//  GraphAnimation
//
//  Created by Libor Polehna on 10/07/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Queue Data Structure Protocol.
 */
public protocol DSQueueProtocol {
    
    /// Generic Data Type
    associatedtype DataType
    
    /// Yes, if the queue does not contain any values, otherwise no.
    var isEmpty: Bool { get }
    
    /**
     Add new `data` to the end of queue.
     
     - Parameter data: New data to be added.
     */
    func enqueue(_ data: DataType)
    /**
     Get data from the head of the queue.
     
     - Returns: Data if the queue is not empty, otherwise nil.
     */
    func dequeue() -> DataType?
    
}
