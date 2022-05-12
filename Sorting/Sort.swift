//
//  Sort.swift
//  Problem Solving
//
//  Created by Linkon Sid on 13/1/22.
//

import Foundation


enum SortType:String{
    case MergeSort
    case CountSort
    case InsertionSort
    case HeapSort
}
class Sort{
//    func mergeSort(arr:[Int]) -> [Int] {
//        if arr.count>1{
//            var sortedArr = arr
//            let mid = arr.count/2
//            let arr1 = mergeSort(arr: Array(sortedArr[0...mid]))
//            let arr2 = mergeSort(arr: Array(sortedArr[mid+1...arr.count-1]))
//            sortedArr = twoWayMergeSortedArr(arr: arr1, arr1: arr2)
//            return sortedArr
//        }
//        return arr
//    }
//    func twoWayMergeSortedArr(arr:[Int],arr1:[Int])->[Int]{
//        var resultArr:[Int] = []
//        var i = 0
//        var j = 0
//        let arrLen = arr.count
//        let arr1Len = arr1.count
//        while i<arrLen && j<arr1Len{
//            if arr1[j]<arr[i]{
//                resultArr.append(arr1[j])
//                j += 1
//            }
//            else{
//                resultArr.append(arr[i])
//                i += 1
//            }
//        }
//        while(i<arrLen){
//            resultArr.append(arr[i])
//            i += 1
//        }
//        while(j<arr1Len){
//            resultArr.append(arr1[j])
//            j += 1
//        }
//        return resultArr
//    }
    static func validateSortedOutput(input:[[Int]],type:SortType){
        var status = true
        for i in 0..<input.count {
            let expected = input[i].sorted()
            let actual = getSortedOutput(arr: input[i], type: type)
            if expected != actual{
                status = false
                print("expected \(expected)\n actual \(actual)")
            }
        }
        if status{
            print("all test cases passed")
        }
    }
    static func getSortedOutput(arr:[Int],type:SortType)->[Int]{
        switch type {
        case .CountSort:
            return arr.countSort()
        case .InsertionSort:
            return arr.insertionSort()
        case .HeapSort:
            var inpArr = arr
            return inpArr.heapSort()
        case .MergeSort:
            return arr
        }
    }
}

extension Array where Element == Int{
    mutating func heapSort()->[Int]{
        // two steps for heapsort
        // 1. create heap/heapify
        // 2. follow the process of deleting item from heap to sort items
        self.heapify()
        self.deleteFromHeap()
        return self
    }
    // creates heap from top-down approach
    mutating func heapify(){
        var curr = self.count - 1
        while(curr>=0){
            swapCall(i: curr, length: self.count - 1)
            curr -= 1
        }
    }
    mutating func swapCall(i:Int,length:Int){
        let leftChild = 2*i + 1
        let rightChild = 2*i + 2
        if leftChild <= length && rightChild <= length {
            if self[leftChild]>self[rightChild] && self[leftChild]>self[i]{
                self.swapAt(i, leftChild)
                swapCall(i: leftChild, length: length)
            }
            else if self[rightChild]>self[i]{
                self.swapAt(i, rightChild)
                swapCall(i: rightChild, length: length)
            }
            else{
                return
            }
        }
        else if leftChild <= length,self[leftChild]>self[i]{
            self.swapAt(i, leftChild)
                swapCall(i: leftChild, length: length)
        }
        else if rightChild <= length,self[rightChild]>self[i]{
            self.swapAt(i, rightChild)
                swapCall(i: rightChild, length: length)
        }
        else{
            return
        }
    }
    mutating func deleteRootFromHeap(end:Int){
        let start = 0
        var endPointer = end
        self.swapAt(start, end)
        var i = start
        endPointer -= 1
        while(i<=endPointer){
            let leftChild = 2*i + 1
            let rightChild = 2*i + 2
            if leftChild <= endPointer && rightChild <= endPointer{
                if self[leftChild]>self[rightChild] && self[leftChild]>self[i]{
                    self.swapAt(i, leftChild)
                    i = leftChild
                }
                else if self[rightChild]>self[i]{
                    self.swapAt(i, rightChild)
                    i = rightChild
                }
                else{
                    break
                }
            }
            else if leftChild <= endPointer,self[leftChild]>self[i]{
                self.swapAt(i, leftChild)
                i = leftChild
            }
            else if rightChild <= endPointer,self[rightChild]>self[i]{
                self.swapAt(i, rightChild)
                i = rightChild
            }
            else{
                break
            }
        }
    }

    //creates heap from bottom-up approach
    mutating func deleteFromHeap(){
        let start = 0
        var end = self.count-1
        while(end>start){
            if end == 1 && self[end] > self[start]{break}
            let temp = self[end]
            self[end] = self[start]
            self[start] = temp
            end -= 1
            var i = start
            while(i<=end){
                let leftChild = 2*i + 1
                let rightChild = 2*i + 2
                if leftChild > end || rightChild > end {break}
                if self[leftChild]>self[rightChild] && self[leftChild]>self[i]{
                    self.swapAt(i, leftChild)
                    i = leftChild
                }
                else if self[rightChild]>self[i]{
                    self.swapAt(i, rightChild)
                    i = rightChild
                }
                else{break}
            }
        }
    }
    mutating func insertAtHeap(end:Int,item:Int){
        self.append(item)
        var a = end
        self.swapAt(a, self.count-1)
        while(a>0){
            let parent = (a-1)/2
            if self[a]>self[parent]{
                self.swapAt(a, parent)
                a = parent
            }
            else{break}
        }
    }
    mutating func createMaxHeap(){
        for i in 1..<self.count{
            var a = i
            while(a>0){
                let parent = (a-1)/2
                if self[a]>self[parent]{
                    let temp = self[a]
                    self[a] = self[parent]
                    self[parent] = temp
                    a = parent
                }
                else{
                    break
                }
            }
        }
    }
    func insertionSort()->[Int]{
        var arr = self
        for i in 0..<arr.count{
            for j in i..<arr.count{
                if arr[j] < arr[i]{
                    arr.swapAt(i, j)
                }
            }
        }
        return arr
    }
    func countSort()->[Int]{
        let length = self.count
        guard let max = self.max(), let min = self.min() else{return []}
        let range = max-min+1
        var resultArr:[Int] = [Int](repeating: -1, count: length)
        var countingArr:[Int] = [Int](repeating: 0, count: range)
        // count items
        for i in 0..<length{
            countingArr[self[i]-min] += 1
        }
        // cumulative count by adding to previous item count
        for i in 1..<countingArr.count{
            countingArr[i] += countingArr[i-1]
        }
        // assign the counting array index as the value of result array
        for i in stride(from: length-1, to: -1, by: -1){
            resultArr[countingArr[self[i]-min]-1] = self[i]
            countingArr[self[i]-min] -= 1
        }
        return resultArr
    }
    func validateOutput()->(isValid:Bool,expected:[Int],actual:[Int]){
        let sortedArr = insertionSort()
        return (self == sortedArr,sortedArr,self)
    }

}


