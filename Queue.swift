//
//  Queue.swift
//  Problem Solving
//
//  Created by Linkon Sid on 6/5/22.
//

import Foundation

struct Queue {
    var front:Node?
    var rear:Node?
    private var count:Int
    var size:Int{
        get{
            return self.count
        }
    }
    init(){
        self.count = 0
    }
    mutating func enqueue(_ value: TreeNode) {
        let node = Node(value)
        if isEmpty{
            self.front = node
        }
        else{
            self.rear?.next = node
        }
        self.count += 1
        self.rear = node
    }
    mutating func dequeue() -> Node?{
        if isEmpty{
            print("queue is empty")
            return nil
        }
        let node = front
        front = front?.next
        count -= 1
        if isEmpty{ // deleting last item of a node
            rear = nil
        }
        return node
    }
    var isEmpty:Bool{
        return (front == nil)
    }
    var head: Node? {
        return front
    }
    var tail: Node? {
        return rear
    }
    func display(){
        var node = front
        while let p = node{
            print(p.data.val)
            node = p.next
        }
        print("\n")
    }
}
