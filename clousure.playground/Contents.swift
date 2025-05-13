import Foundation

// MARK: - Closures in Swift Playground

// MARK: 1. Basic Closure Example

let greeting = { (name: String) -> String in
    return "Hello, \(name)"
}
print(greeting("Armando")) // Output: "Hello, Armando"


// MARK: 2. Escaping vs Non-Escaping Closures

// Escaping closures: executed after the function returns
func performEscapingClosure(completion: @escaping @Sendable () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        completion()
    }
}

performEscapingClosure {
    print("This is an escaping closure")
}

// Non-escaping closures: executed within the function body
func performNonEscapingClosure(completion: () -> Void) {
    completion()
}

performNonEscapingClosure {
    print("This is a non-escaping closure")
}


// MARK: 3. Trailing Closure Syntax

func performTask(completion: () -> Void) {
    // some code here
    completion()
}

performTask {
    print("Task completed using trailing closure")
}


// MARK: 4. Autoclosure Example

func logIfTrue(_ value: @autoclosure () -> Bool) {
    if value() {
        print("Value is true")
    }
}

logIfTrue(5 > 3) // The expression is evaluated only when used


// MARK: 5. Passing Variables into a Closure

let number = 5
let closure = {
    print("Number is \(number)")
}
closure() // Output: "Number is 5"


// MARK: 6. Capturing External Variables

var total = 0
let addToTotal: (Int) -> Void = { value in
    total += value
}
addToTotal(5)
print("Total after adding: \(total)") // Output: 5

