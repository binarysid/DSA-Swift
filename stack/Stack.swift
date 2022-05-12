//
//  Stack.swift
//  Problem Solving
//
//  Created by Linkon Sid on 2/3/22.
//

import Foundation

class Stack<T>{
    private var items:[T] = []
    private var size:Int = 0
    var isFull:Bool{
        return items.count == size
    }
    var isEmpty:Bool{
        items.isEmpty
    }
    init(_ size:Int){
        self.size = size
    }
    func top() -> T? {
        guard let topElement = items.first else { return nil }
        return topElement
    }
    func push(val:T){
        guard !self.isFull else{return}
        items.insert(val, at: 0)
    }
    func pop(){
        guard !self.isEmpty else{return}
        items.removeFirst()
    }
    func getItems()->[T?]{
        return items
    }
}
