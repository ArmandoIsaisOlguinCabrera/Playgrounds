import Foundation

// MARK: 1. Uses mathematical (arithmetic) operators
let sum = 5 + 3
let difference = 10 - 2
let product = 4 * 2
let quotient = 8 / 2
let remainder = 9 % 4

print("Sum: \(sum), Difference: \(difference), Product: \(product), Quotient: \(quotient), Remainder: \(remainder)")

// MARK: 2. Uses basic operators (comparison, logical)
let a = 5
let b = 10

let isEqual = a == b
let isGreater = a > b
let isLess = a < b
let logicalAnd = a > 0 && b > 0
let logicalOr = a < 0 || b > 0

print("Equal: \(isEqual), Greater: \(isGreater), Less: \(isLess)")
print("Logical AND: \(logicalAnd), Logical OR: \(logicalOr)")

// MARK: 3. Uses string operators (concatenate, comparison, logical)
let first = "Hello"
let second = "World"
let message = first + " " + second
let areStringsEqual = first == second

print("Message: \(message), Strings equal: \(areStringsEqual)")

// MARK: 4. Uses ternary operator
let age = 20
let access = age >= 18 ? "Allowed" : "Denied"
print("Access: \(access)")

// MARK: 5. Creates annotation, documentation and navigation comments

/// Calculates the square of a number.
/// - Parameter number: The number to square.
/// - Returns: The squared value.
func square(of number: Int) -> Int {
    return number * number
}

let result = square(of: 6)
print("Square of 6 is \(result)")

// TODO: Add more utility functions
// FIXME: This is a placeholder for future improvements

// MARK: 6. Handles optional values with defined operators (Swift only)
let optionalName: String? = nil

// Optional chaining
let count = optionalName?.count

// Nil-coalescing operator
let displayName = optionalName ?? "Anonymous"

// Forced unwrapping (use with caution)
let forcedUnwrap = optionalName != nil ? optionalName! : "Default"

print("Optional chaining count: \(String(describing: count))")
print("Display name: \(displayName)")
print("Forced unwrap: \(forcedUnwrap)")
