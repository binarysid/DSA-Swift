//
//  Heap.swift
//  Problems
//
//  Created by Linkon Sid on 21/5/22.
//

import Foundation

class TrieNode<T: Hashable> {
    var value: T?
    weak var parent: TrieNode?
    var children: [T: TrieNode] = [:]
    var wordCount:Int = 0 // denotes that if we travel from root we will find this number of string
    var prefixCount = 0
    
    init(value: T? = nil, parent: TrieNode? = nil, wordCount:Int = 0,prefixCount:Int=1) {
        self.value = value
        self.parent = parent
        self.wordCount = wordCount
        self.prefixCount = prefixCount
    }
    func add(child: T) {
        guard children[child] == nil else { return }
        children[child] = TrieNode(value: child, parent: self)
        
    }
    
}

class Trie {
    typealias Node = TrieNode<Character>
    fileprivate let root:Node
    var totalItem = 0
    init() {
        root = Node()
    }
}
extension Trie {
    func prefixCount(_ word:String)->Int{
        guard !word.isEmpty else { return 0}
        var currentNode = root
        var index = 0
        let charaters = Array(word.lowercased())
        while index < charaters.count{
            let character = charaters[index]
            guard let child = currentNode.children[character] else{return 0}
            currentNode = child
            index += 1
        }
        return currentNode.prefixCount
    }
    func delete(_ word:String)->Bool{
        guard !word.isEmpty else { return false}
        var currentNode = root
        let characters = Array(word.lowercased())
        var currIndex = 0
        while currIndex < characters.count{
            let character = characters[currIndex]
            if let child = currentNode.children[character]{
                currentNode = child
                currIndex += 1
            }
            else{
                return false
            }
        }
        if currentNode.wordCount>0{
            currentNode.wordCount -= 1
            return true
        }
        return false
    }
    func getLongestPrefix(_ str:String)->String{
        guard str.count>0 else{return ""}
        var currentNode = root
        let characters = Array(str.lowercased())
        var currentIndex = 0
        var longestPrefix = ""
        while currentIndex < characters.count {
            let character = characters[currentIndex]
            if let child = currentNode.children[character],child.prefixCount==totalItem {
                longestPrefix += String(character)
                currentNode = child
            }
            else{break}
            currentIndex += 1
        }
        return longestPrefix
    }
    func startsWith(_ prefix: String) -> Bool {
        var currentNode = root
        let characters = Array(prefix.lowercased())
        var currentIndex = 0
        while currentIndex < characters.count {
            let character = characters[currentIndex]
            if let child = currentNode.children[character] {
                currentNode = child
            } else {
                return false
            }
            currentIndex += 1
        }
        return true
    }
    func insert(_ word: String) {
        var currentNode = root
        let characters = Array(word.lowercased())
        var currentIndex = 0
        while currentIndex < characters.count {
            let character = characters[currentIndex]
            if let child = currentNode.children[character] {
                currentNode = child
                currentNode.prefixCount += 1
            } else {
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }
            currentIndex += 1
        }
        if currentIndex == characters.count {
            currentNode.wordCount += 1
        }
        totalItem += 1
    }
    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        var currentNode = root
        let characters = Array(word.lowercased())
        var currentIndex = 0
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            currentIndex += 1
            currentNode = child
        }
        if currentIndex == characters.count && currentNode.wordCount>0 {
            return true
        } else {
            return false
        }
    }
}
