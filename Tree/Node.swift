//
//  BinaryTree.swift
//  Problem Solving
//
//  Created by Linkon Sid on 6/5/22.
//

import Foundation

class Node{
    var data: TreeNode
    var next: Node?
    init(_ node:TreeNode) {
        self.data = node
    }
}
// compare one node against another
//extension Node: Equatable where T: Equatable {
//    public static func ==(lhs: Node<T>, rhs: Node<T>) -> Bool {
//        lhs.value == rhs.value && lhs.next == rhs.next
//    }
//}
class TreeNode{
    var val:Int
    var left:TreeNode?
    var right:TreeNode?
    init(value:Int) {
        self.val = value
    }
}


