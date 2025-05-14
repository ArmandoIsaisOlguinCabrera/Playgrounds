import Foundation

// MARK: - Primitive and Specialized Collections

// Primitive Collection: Array
var numbers: [Int] = [1, 2, 3, 4, 5]

// Specialized Collection: Set (ensures uniqueness)
var uniqueNumbers: Set<Int> = [1, 2, 2, 3, 3, 4] // Duplicates are removed

print("Unique numbers: \(uniqueNumbers)")

// Specialized Collection: Dictionary (HashMap)
var userAges: [String: Int] = ["Alice": 30, "Bob": 25]
userAges["Charlie"] = 28
print("User Ages:", userAges)

// MARK: - Lazy Collection

let largeArray = Array(1...1_000_000)
let lazyFiltered = largeArray.lazy.filter { $0 % 2 == 0 } // No memory overhead until used

print("First 5 even numbers from lazy filter:")
for number in lazyFiltered.prefix(5) {
    print(number)
}

// MARK: - Tuple Usage

let user: (id: Int, name: String, isActive: Bool) = (id: 101, name: "Ana", isActive: true)
print("User name from tuple: \(user.name)")

// MARK: - Mutable vs Immutable Collections

let immutableArray = [1, 2, 3] // Immutable
// immutableArray.append(4) // ❌ Error

var mutableArray = [1, 2, 3]
mutableArray.append(4) // ✅ OK
print("Mutable array:", mutableArray)

// MARK: - Custom Collection with Sequence Conformance

struct Countdown: Sequence {
    let start: Int

    func makeIterator() -> CountdownIterator {
        return CountdownIterator(current: start)
    }
}

struct CountdownIterator: IteratorProtocol {
    var current: Int

    mutating func next() -> Int? {
        guard current > 0 else { return nil }
        defer { current -= 1 }
        return current
    }
}

let countdown = Countdown(start: 5)
print("Countdown using custom collection:")
for number in countdown {
    print(number)
}

// MARK: - Pointer Collection Example (Optional)

// NSPointerArray is an Objective-C collection class that holds weak references
let pointerArray = NSPointerArray.weakObjects()

class MyClass {}
var object1: MyClass? = MyClass()
var object2: MyClass? = MyClass()

pointerArray.addPointer(Unmanaged.passUnretained(object1!).toOpaque())
pointerArray.addPointer(Unmanaged.passUnretained(object2!).toOpaque())

print("Pointer array count (before deallocation):", pointerArray.count)

object1 = nil
object2 = nil

pointerArray.compact() // Clean up nil references
print("Pointer array count (after deallocation):", pointerArray.count)
