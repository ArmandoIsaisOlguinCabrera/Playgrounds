import Foundation

// MARK: - Collective Types: Pros & Cons

print("Using collective types like `Any` or `AnyObject`")

let mixedArray: [Any] = [1, "String", Date(), 3.14]

for item in mixedArray {
    if item is Int {
        print("Found Int: \(item)")
    } else if item is String {
        print("Found String: \(item)")
    } else {
        print("Unknown type: \(item)")
    }
}

// MARK: - Type Checking

print("\n2️⃣ Type Checking")

let value: Any = 42

if value is Int {
    print("It's an Int")
} else {
    print("It's not an Int")
}

// MARK: - Type Casting

print("\n3️⃣ Type Casting")

let unknownValue: Any = "Hello, Swift!"

if let stringValue = unknownValue as? String {
    print("Casted to String: \(stringValue)")
} else {
    print("Casting failed")
}

// Force casting (dangerous if wrong type)
// let forcedString = unknownValue as! String

// MARK: - Protocol Conformance

print("Protocol Conformance")

protocol Drivable {
    func drive()
}

struct Car: Drivable {
    func drive() {
        print("🚗 Driving a car")
    }
}

let car: Any = Car()

if let drivableCar = car as? Drivable {
    drivableCar.drive()
}

// MARK: - Upcasting & Downcasting

print("Upcasting & Downcasting")

class Animal {
    func makeSound() {
        print("Some animal sound")
    }
}

class Dog: Animal {
    func bark() {
        print("Woof!")
    }
}

let dog = Dog()

// Upcasting (safe)
let pet: Animal = dog
pet.makeSound()

// Downcasting (need to check)
if let bulldog = pet as? Dog {
    bulldog.bark()
}

// MARK: - Any vs AnyObject


let intVal: Any = 10
let stringObj: AnyObject = NSString(string: "Swift Object")

print("Any value: \(intVal)")
print("AnyObject: \(stringObj)")
