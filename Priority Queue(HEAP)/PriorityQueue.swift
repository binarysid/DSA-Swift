//
//  Heap.swift
//  Problems
//
//  Created by Linkon Sid on 21/5/22.
//

import Foundation

enum PriorityType{
    case min
    case max
}
internal extension PriorityType{
    func getComparator<Int: Comparable>() -> (Int, Int) -> Bool {
        switch self {
        case .min:
            return (<)
        case .max:
            return (>)
        }
    }
}
class PriorityQueue{
    private var item:[Int] = []
    var comparator : (Int, Int) -> Bool{
        type.getComparator()
    }
    private var type:PriorityType
    init(_ item:[Int],type:PriorityType){
        if item.count == 0{fatalError("initializer with zero item not allowed")}
        self.item = item
        self.type = type
        self.heapify()
    }
    public init(){
        fatalError("initializer with zero item not allowed")
    }
    private func heapify(){
        var curr = self.item.count - 1
        while(curr>=0){
            swapCall(i: curr, length: self.item.count - 1)
            curr -= 1
        }
    }
    private func swapCall(i:Int,length:Int){
        let leftChild = 2*i + 1
        let rightChild = 2*i + 2
        if leftChild <= length && rightChild <= length {
            if comparator( self.item[leftChild],self.item[rightChild]) && comparator(self.item[leftChild],self.item[i]){
                self.item.swapAt(i, leftChild)
                swapCall(i: leftChild, length: length)
            }
            else if comparator(self.item[rightChild],self.item[i]){
                self.item.swapAt(i, rightChild)
                swapCall(i: rightChild, length: length)
            }
            else{
                return
            }
        }
        else if leftChild <= length,comparator(self.item[leftChild],self.item[i]){
            self.item.swapAt(i, leftChild)
                swapCall(i: leftChild, length: length)
        }
        else if rightChild <= length,comparator(self.item[rightChild],self.item[i]){
            self.item.swapAt(i, rightChild)
                swapCall(i: rightChild, length: length)
        }
        else{
            return
        }
    }
    func add(val:Int){
        self.item.append(val)
        var a = item.count-1
        while(a>0){
            let parent = (a-1)/2
            if comparator(self.item[a],self.item[parent]){
                self.item.swapAt(a, parent)
                a = parent
            }
            else{break}
        }
    }
    // heap delete always removes item from root
    func remove(){
        let start = 0
        let end = item.count-1
        var endPointer = end
        self.item.swapAt(start, end)
        self.item.remove(at: end)
        var i = start
        endPointer -= 1
        while(i<=endPointer){
            let leftChild = 2*i + 1
            let rightChild = 2*i + 2
            if leftChild <= endPointer && rightChild <= endPointer{
                if comparator(self.item[leftChild],self.item[rightChild]) && comparator(self.item[leftChild],self.item[i]){
                    self.item.swapAt(i, leftChild)
                    i = leftChild
                }
                else if comparator(self.item[rightChild],self.item[i]){
                    self.item.swapAt(i, rightChild)
                    i = rightChild
                }
                else{
                    break
                }
            }
            else if leftChild <= endPointer,comparator(self.item[leftChild],self.item[i]){
                self.item.swapAt(i, leftChild)
                i = leftChild
            }
            else if rightChild <= endPointer,comparator(self.item[rightChild],self.item[i]){
                self.item.swapAt(i, rightChild)
                i = rightChild
            }
            else{
                break
            }
        }
    }
    func peek()->Int{
        return item.first!
    }
    func toArray()->[Int]{
        return item
    }
    func size()->Int{
        return item.count
    }
    func clear(){
        item = []
    }
    func poll()->Int{
        let root = item.first!
        item.remove(at: 0)
        return root
    }
}
