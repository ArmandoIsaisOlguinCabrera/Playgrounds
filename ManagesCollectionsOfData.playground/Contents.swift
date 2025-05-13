import Foundation

// MARK: - Arrays

/// Arrays are ordered collections that allow duplicate elements.
print("🔷 ARRAY EXAMPLE")

// Empty Array
var emptyFruits: [String] = []
print("Empty Array:", emptyFruits)

var fruits: [String] = ["Apple", "Banana", "Orange"]

// Add
fruits.append("Pear")

// Remove
fruits.remove(at: 1) // Removes "Banana"

// Update
fruits[0] = "Mango"

print("Current Fruits:", fruits)
print("First Fruit:", fruits.first ?? "None")
print("---------------------------")


// MARK: - Dictionaries

/// Dictionaries store key-value pairs with unique keys.
print("🟨 DICTIONARY EXAMPLE")

// Empty Dictionary
var emptyCapitals: [String: String] = [:]
print("Empty Dictionary:", emptyCapitals)

var capitals: [String: String] = [
    "France": "Paris",
    "Japan": "Tokyo"
]

// Add or update
capitals["Mexico"] = "Mexico City"
capitals["France"] = "Lyon" // Updates France

// Remove
capitals.removeValue(forKey: "Japan")

print("Current Capitals:", capitals)
print("Capital of France:", capitals["France"] ?? "Unknown")
print("---------------------------")


// MARK: - Sets

/// Sets store unique, unordered elements.
print("🟩 SET EXAMPLE")

// Empty Set
var emptyNumbers = Set<Int>()
print("Empty Set:", emptyNumbers)

var uniqueNumbers: Set<Int> = [1, 2, 3]

// Add (ignores duplicates)
uniqueNumbers.insert(4)
uniqueNumbers.insert(2) // Ignored

// Remove
uniqueNumbers.remove(1)

// Simulate update
uniqueNumbers.remove(3)
uniqueNumbers.insert(10)

print("Current Set:", uniqueNumbers)
print("---------------------------")


// MARK: - Mixed Types in Collections

/// Arrays can store mixed types using the `Any` type.
print("🔶 MIXED TYPES EXAMPLE")

// Empty mixed array
let emptyMixed: [Any] = []
print("Empty Mixed Array:", emptyMixed)

let mixedValues: [Any] = [42, "Swift", true, 3.14]

for item in mixedValues {
    switch item {
    case let number as Int:
        print("Int:", number)
    case let text as String:
        print("String:", text)
    case let boolean as Bool:
        print("Bool:", boolean)
    case let decimal as Double:
        print("Double:", decimal)
    default:
        print("Unknown Type")
    }
}
print("---------------------------")


// MARK: - Protocol-Based Polymorphism

/// Use protocols to store different objects that share behavior.
print("🌀 PROTOCOL-BASED COLLECTION")

protocol Displayable {
    func display()
}

struct User: Displayable {
    let name: String
    func display() {
        print("👤 User:", name)
    }
}

struct Product: Displayable {
    let title: String
    func display() {
        print("📦 Product:", title)
    }
}

// Empty Displayable array
let emptyDisplayables: [Displayable] = []
print("Empty Displayable Collection:", emptyDisplayables)

let displayItems: [Displayable] = [
    User(name: "Alice"),
    Product(title: "MacBook Pro")
]

displayItems.forEach { $0.display() }

print("---------------------------")


// MARK: - When to Use Each Collection

/// Summary: choosing the right collection for the task.
print("📌 WHEN TO USE WHICH COLLECTION")

print("""
✅ Array:
   - Ordered
   - Allows duplicates
   - Great for UI lists, ordered data

✅ Dictionary:
   - Key-value mapping
   - Unique keys
   - Useful for fast lookups (e.g., settings, IDs)

✅ Set:
   - Unordered
   - Unique elements
   - Best for fast checks (e.g., checking duplicates)
""")
