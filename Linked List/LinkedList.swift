//
//  LinkedList.swift
//  Problem Solving
//
//  Created by Linkon Sid on 2/12/21.
//

import Foundation
public class LLNode<T>{
    var value: T
    var next:LLNode?
    var prev:LLNode?
    
    init(value:T) {
        self.value = value
    }
}


public class LinkedList<T>{
    public typealias Node = LLNode<T>
    private var head:Node?
    public var first:Node?{
        return head
    }
    public var last:Node?{
        guard var node = head else{return nil}
        while let next = node.next{
            node = next
        }
        return node
    }
    public func append(value:T){
        let newNode = Node(value: value)
        if let lastNode = last{
            newNode.prev = lastNode
            lastNode.next = newNode
        }
        else{
            head = newNode
        }
    }
    public func count()->Int{
        guard var node = head else{
            return 0
        }
        var count = 1
        while let next = node.next{
            node = next
            count += 1
        }
        return count
    }
    public func printAllNodes(){
        guard var node = head else{
            return
        }
        print(node.value)
        while let next = node.next{
            print(next.value)
            node = next
        }
    }
    public func node(atIndex index:Int) -> Node?{
        guard index > 0 else{return head!}
        var node = head!.next
        for _ in 1..<index{
            node = node!.next
            if node == nil{break}
        }
        return node
    }
    public func insert(atIndex index:Int, value:T){
        let newNode = Node(value: value)
        if index == 0 {
            newNode.next = head
            head?.prev = newNode
            head = newNode
        }
        else{
            guard var atPlaceNode = node(atIndex: index) else{return}
            let prev = atPlaceNode.prev
            let next = atPlaceNode.next
            newNode.prev = prev
            newNode.next = next
            atPlaceNode.prev = newNode
            prev?.next = newNode
        }
    }
    public func remove(atIndex index:Int)->T?{
        guard var atPlaceNode = node(atIndex: index) else{return nil}
        var prev = atPlaceNode.prev
        var next = atPlaceNode.next
        if index == 0{
            next?.prev = nil
            head = next
        }
        else{
            prev?.next = next
            next?.prev = prev
        }
        atPlaceNode.prev = nil
        atPlaceNode.next = nil
        return atPlaceNode.value
    }

}

public class ListNode {
    public var val: Int
    public var next: ListNode?

    public init() {
        self.val = 0
        self.next = nil
    }
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

class Solution {
    static func addArrToNodes(arr:[Int])->ListNode?{
        if arr.count==0{
            return nil
        }
        var node = ListNode(arr[0])
        let head = node
        for i in 1..<arr.count{
            node.next = ListNode(arr[i])
            node = node.next!
        }
        return head
    }
    static func middleNode(_ head: ListNode?) -> ListNode? {
        var mid = head
        var b = head
        while(b != nil && b?.next != nil){
            mid = mid?.next
            b = b?.next?.next
        }
        return mid
    }
    static func lastNode(_ head:ListNode?) ->ListNode?{
        guard var node = head else{return nil}
        while let next = node.next{
            node = next
        }
        return node
    }
    static func deleteNode(_ node: ListNode?) {
        node?.val = (node?.next?.val)!
        node?.next = node?.next?.next
    }
    static func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var nodeA:ListNode? = headA
        var nodeB:ListNode? = headB
        while nodeA?.val != nodeB?.val{
            if nodeA == nil{
                nodeA = headB
            }
            else{
                nodeA = nodeA?.next
            }
            if nodeB == nil{
                nodeB = headA
            }
            else{
                nodeB = nodeB?.next
            }
        }
        return nodeA
//        let countA = getHeadCount(head: headA)
//        let countB = getHeadCount(head: headB)
//        if countA>countB{
//            return getInterSectedNode(headA, headB,  countA-countB)
//        }
//        else{
//            return getInterSectedNode(headB, headA,  countB-countA)
//        }
    }
    static func getInterSectedNode(_ headA: ListNode?, _ headB: ListNode?, _ diff:Int )->ListNode?{
        var currA = headA
        var currB = headB
        for _ in 0..<diff{
            if currA == nil{return nil}
            currA = currA?.next
        }
        while(currA?.val != currB?.val){
            currA = currA?.next
            currB = currB?.next
        }
        return currA
    }
    static func getHeadCount(head:ListNode?)->Int{
        var count = 0
        var curr = head
        while curr != nil{
            curr = curr?.next
            count += 1
        }
        return count
    }
    static func getDecimalValue(_ head: ListNode?) -> Int {
        var node = head
        var decimal = 0
        var power = getHeadCount(head: head)-1
        while power >= 0 {
            decimal += node!.val * Int(pow(Double(2),Double(power)))
            power -= 1
            node = node?.next
        }
        return decimal
    }
    static func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var prev:ListNode?
        var node = head
        var current = node
        while node != nil{
            if node?.val == val{
                if prev == nil{
                    current = node?.next
                }
                else{
                    prev?.next = node?.next
                }
            }
            else{
                prev = node
            }
            node = node?.next
        }
        return current
    }
    static func reverseLinkedList(_ head: ListNode?) -> ListNode? {
        var current = head
        var temp:ListNode?,prev:ListNode?
        while current != nil{
            temp = current?.next
            current?.next = prev
            prev = current
            current = temp
        }
        return prev
    }
    static func deleteDuplicatesNonDistinct(_ head: ListNode?) -> ListNode? {
        var node = head
        var currNode = node
        var dup = -101
        while let next = node?.next{
            if node?.val == next.val{
                dup = next.val
                node?.next = next.next
            }
            if node?.val != node?.next?.val{
                if node?.val == dup{
                    dup = -101
                    node?.next = next.next
                }
                node = node?.next
            }
        }
        return currNode
    }

    static func deleteDuplicates(_ head: ListNode?) -> ListNode? {
    var node = head
    var currNode = node
    while let next = node?.next{
        if node?.val == next.val{
            node?.next = next.next
        }
        if node?.val != node?.next?.val{
            node = node?.next
        }
    }
    return currNode
}
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var node = ListNode(0)
        let head = node
        var l1Node = l1
        var l2Node = l2
        var carry = 0
        var sum = 0
        while l1Node != nil || l2Node != nil{
            let l1Val = l1Node?.val != nil ? l1Node!.val : 0
            let l2Val = l2Node?.val != nil ? l2Node!.val : 0
            sum = l1Val + l2Val + carry
            carry = sum/10
            node.val = sum%10
            l1Node = l1Node?.next
            l2Node = l2Node?.next
            if l1Node != nil || l2Node != nil{
                node.next = ListNode(0)
                node = node.next!
            }
            else if carry>0{
                node.next = ListNode(carry )
            }
        }
        return head
    }
    static func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var mergedNode:ListNode?
        var head = mergedNode
        var l1 = list1
        var l2 = list2
        while l1 != nil && l2 != nil{
            if l1!.val <= l2!.val{
                if mergedNode == nil{ // if no node initialized yet
                    mergedNode = ListNode(l1!.val)
                    head = mergedNode
                }
                else{
                    mergedNode!.next = ListNode(l1!.val)
                    mergedNode = mergedNode!.next
                }
                l1 = l1?.next
            }
            else if l1!.val > l2!.val{
                if mergedNode == nil{
                    mergedNode = ListNode(l2!.val)
                    head = mergedNode
                }
                else{
                    mergedNode!.next = ListNode(l2!.val)
                    mergedNode = mergedNode!.next
                }
                l2 = l2?.next
            }
        }
        if l1 != nil{
            if mergedNode == nil{ // if the while condition above is not executed once. this can happen if l1 = [0] & l2 = []
                head = l1
            }
            else{
                mergedNode!.next = l1
            }
        }
        else if l2 != nil{
            if mergedNode == nil{// if the while condition above is not executed once. this can happen if l1 = [] & l2 = [0]
                head = l2
            }
            else{
                mergedNode!.next = l2
            }
        }
        return head
    }
    static func printAllNodes(lNode:ListNode?){
        guard var node = lNode else{
            return
        }
        print(node.val)
        while let next = node.next{
            print(next.val)
            node = next
        }
    }
}
