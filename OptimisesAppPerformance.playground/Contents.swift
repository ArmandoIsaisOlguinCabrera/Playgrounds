import Foundation

// MARK: - O(1) Constant Time
func getFirstElement(arr: [Int]) {
    if let first = arr.first {
        print("O(1) Constant Time: \(first)")
    }
}

// MARK: - O(n) Linear Time
func linearSearch(arr: [Int], target: Int) -> Int? {
    for (index, value) in arr.enumerated() {
        if value == target {
            return index
        }
    }
    return nil
}

// MARK: - O(log n) Binary Search (Array must be sorted)
func binarySearch(arr: [Int], target: Int) -> Int? {
    var low = 0
    var high = arr.count - 1
    
    while low <= high {
        let mid = (low + high) / 2
        if arr[mid] == target {
            return mid
        } else if arr[mid] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return nil
}

// MARK: - O(n^2) Bubble Sort
func bubbleSort(_ array: inout [Int]) {
    for i in 0..<array.count {
        for j in 0..<array.count - i - 1 {
            if array[j] > array[j + 1] {
                array.swapAt(j, j + 1)
            }
        }
    }
}

// MARK: - O(n log n) Merge Sort
func mergeSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    let middle = array.count / 2
    let left = mergeSort(Array(array[..<middle]))
    let right = mergeSort(Array(array[middle...]))
    
    return merge(left, right)
}

func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var merged: [Int] = []
    var i = 0
    var j = 0
    
    while i < left.count && j < right.count {
        if left[i] < right[j] {
            merged.append(left[i])
            i += 1
        } else {
            merged.append(right[j])
            j += 1
        }
    }
    
    return merged + left[i...] + right[j...]
}

// MARK: - Demo Calls
let numbers = [5, 3, 9, 1, 6]
getFirstElement(arr: numbers)

if let index = linearSearch(arr: numbers, target: 9) {
    print("O(n) Linear Search: Found 9 at index \(index)")
}

let sorted = numbers.sorted()
if let index = binarySearch(arr: sorted, target: 6) {
    print("O(log n) Binary Search: Found 6 at index \(index)")
}

var numsToSort = [10, 3, 5, 8, 2]
bubbleSort(&numsToSort)
print("O(n^2) Bubble Sort:", numsToSort)

let mergeSorted = mergeSort([10, 1, 4, 3, 8, 2])
print("O(n log n) Merge Sort:", mergeSorted)
