//
//  Tree.swift
//  Problem Solving
//
//  Created by Linkon Sid on 6/5/22.
//

import Foundation

class Tree{
    var elements:[Int?] = []
    var root: TreeNode?
    init(_ elements:[Int?]) {
        self.elements = elements
    }
    func create()->TreeNode?{
        if elements.isEmpty{return nil}
        var p:TreeNode?
        var queue = Queue()
        root = TreeNode(value: elements[0]!)
        queue.enqueue(root!)
        var i = 1
        while(i<elements.count){
            p = queue.dequeue()?.data
            if let val = elements[i]{ // add leftchild
                let t = TreeNode(value: val)
                p?.left = t
                queue.enqueue(t)
            }
            i += 1
            if i<elements.count, let val = elements[i]{ // add rightchild
                let t = TreeNode(value: val)
                p?.right = t
                queue.enqueue(t)
            }
            i += 1
        }
        return root
    }
    func preorder(node:TreeNode?){
        if node != nil{
            print(node!.val)
            preorder(node: node?.left)
            preorder(node: node?.right)
        }
    }
    func inorder(node:TreeNode?){
        if node != nil{
            inorder(node: node?.left)
            print(node!.val)
            inorder(node: node?.right)
        }
    }
    func postorder(node:TreeNode?){
        if node != nil{
            postorder(node: node?.left)
            postorder(node: node?.right)
            print(node!.val)
        }
    }
    func maxDepth(node:TreeNode?)->Int{
        if node == nil{return 0}
        return 1+max(maxDepth(node: node?.left),maxDepth(node: node?.right))
    }
    func minDepth(node:TreeNode?)->Int{
        if node == nil{return 0}
        else if node?.left == nil && node?.right == nil{return 1}
        else if node?.left != nil && node?.right != nil{
            return 1+min(minDepth(node: node?.left),minDepth(node: node?.right))
        }
        else if node?.left == nil && node?.right != nil{
            return 1+minDepth(node: node?.right)
        }
        else{
            return 1+minDepth(node: node?.left)
        }
    }
    func levelOrder(_ root: TreeNode?) -> [[Int]] {// BFS
        if root  == nil {return []}
        var arr:[[Int]] = []
        var queue = Queue()
        queue.enqueue(root!)
        while(!queue.isEmpty){
            var nodeCount = queue.size
            var tempArr:[Int] = []
            while nodeCount>0{
                let p = queue.dequeue()?.data
                tempArr.append(p!.val)
                if p?.left != nil{
                    queue.enqueue((p?.left)!)
                }
                if p?.right != nil{
                    queue.enqueue((p?.right)!)
                }
                nodeCount -= 1
                if nodeCount == 0{
                    arr.append(tempArr)
                    tempArr = []
                }
            }
        }
        return arr
    }
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        if root  == nil {return []}
        var arr:[Double] = []
        var queue = Queue()
        queue.enqueue(root!)
        while(!queue.isEmpty){
            var nodeCount = queue.size
            let count = nodeCount
            var sum:Double = 0
            while nodeCount>0{
                let p = queue.dequeue()?.data
                sum += Double(p!.val)
                if p?.left != nil{
                    queue.enqueue((p?.left)!)
                }
                if p?.right != nil{
                    queue.enqueue((p?.right)!)
                }
                nodeCount -= 1
                if nodeCount == 0{
                    sum /= Double(count)
                    arr.append(sum)
                }
            }
        }
        return arr
    }
    func findDepth(_ root:TreeNode?, _ val:Int)->Int{
        if root == nil{return -1}
        var dist = -1
        if (root!.val == val){
            return dist+1
        }
        else{
            let dist1 = findDepth(root?.left, val)
            let dist2 = findDepth(root?.right, val)
            if dist1>=0{
                dist = dist1
            }
            else if dist2>=0{
                dist = dist2
            }
            else{return dist}
        }
        return dist + 1
    }
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        let xNode = searchNode(root, x, root)
        let yNode = searchNode(root, y, root)
        return xNode.depth == yNode.depth && xNode.parent!.val != yNode.parent!.val
    }
    func searchNode(_ node: TreeNode?, _ val: Int,_ parent:TreeNode?)->(parent: TreeNode?,depth:Int){
        if node == nil{return (nil,-1)}
        var dist = -1
        var parentNode:TreeNode?
        if node!.val == val{
            return (parent,dist+1)
        }
        else{
            let left = searchNode(node?.left, val, node)
            let right = searchNode(node?.right, val, node)
            if left.parent != nil, left.depth>=0 {
                parentNode = left.parent
                dist = left.depth
            }
            else if right.parent != nil,right.depth>=0{
                parentNode = right.parent
                dist = right.depth
            }
            else{
                return (parentNode,dist)
            }
        }
        return (parentNode,dist+1)
    }
//    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
//        if root  == nil {return false}
//        var queue = Queue()
//        queue.enqueue(root!)
//        var xVal = 0
//        var yVal = 0
//        var xParent:TreeNode?
//        var yParent:TreeNode?
//        var parent:Node?
//        while(!queue.isEmpty){
//            var nodeCount = queue.size
//            let count = nodeCount
//            var tmpParent:Node?
//            while nodeCount>0{
//                if nodeCount == count{
//                    tmpParent = queue.front
//                }
//                let p = queue.dequeue()?.data
//                if p!.val == x{
//                    xVal = p!.val
//                    xParent = parent?.data
//                    print("x val: \(xVal) parent: \(xParent!.val)")
//                }
//                else if p!.val == y{
//                    yVal = p!.val
//                    yParent = parent?.data
//                    print("y val: \(yVal) parent: \(yParent!.val)")
//                }
//                if xVal > 0 && yVal>0{
//                    if xParent!.val != yParent?.val{
//                        return true
//                    }
//                }
//                if p?.left != nil{
//                    queue.enqueue((p?.left)!)
//                }
//                if p?.right != nil{
//                    queue.enqueue((p?.right)!)
//                }
//                nodeCount -= 1
//                if nodeCount == 0{
//                    parent = tmpParent
//                    print("parent set to \(parent!.data.val),  left: \(p?.left?.val), right: \(p?.right?.val) ")
//                }
//            }
//        }
//        return false
//    }
}

//final class TreeNode<Value> {
//    var value: Value
//    private(set) var children: [TreeNode]
//    func add(child: TreeNode) {
//        children.append(child)
//    }
//    init(_ value: Value) {
//        self.value = value
//        children = []
//    }
//
//    init(_ value: Value, children: [TreeNode]) {
//        self.value = value
//        self.children = children
//    }
//}
//// compare one node against another
//extension TreeNode: Equatable where Value: Equatable {
//    static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
//        lhs.value == rhs.value && lhs.children == rhs.children
//    }
//}
