import Foundation

// MARK: - Classes and Structures

// Class definition with properties and methods
class Person {
    var name: String
    var age: Int

    // Computed property
    var description: String {
        return "\(name) is \(age) years old."
    }

    // Initializer
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    // Instance method
    func celebrateBirthday() {
        age += 1
        print("Happy birthday, \(name)! Now you're \(age).")
    }
}

let person = Person(name: "Armando", age: 28)
print(person.description)
person.celebrateBirthday()

// MARK: - Struct (Value Type)

struct Coordinates {
    var latitude: Double
    var longitude: Double
}

let cityLocation = Coordinates(latitude: 19.4326, longitude: -99.1332)
print("Coordinates: \(cityLocation.latitude), \(cityLocation.longitude)")

// MARK: - Inheritance

class Animal {
    var name: String

    init(name: String) {
        self.name = name
    }

    func speak() {
        print("\(name) makes a sound.")
    }
}

class Dog: Animal {
    override func speak() {
        print("\(name) says: Woof!")
    }
}

let dog = Dog(name: "Max")
dog.speak()

// MARK: - Enum with Iterable Cases

enum TransportMode: String, CaseIterable {
    case car, bike, airplane, boat

    func speed() -> String {
        switch self {
        case .car: return "100 km/h"
        case .bike: return "25 km/h"
        case .airplane: return "800 km/h"
        case .boat: return "50 km/h"
        }
    }
}

for mode in TransportMode.allCases {
    print("Mode: \(mode.rawValue), Speed: \(mode.speed())")
}

// MARK: - Nested Types

struct Computer {
    struct Specifications {
        var cpu: String
        var ram: Int
    }

    var brand: String
    var specs: Specifications
}

let mac = Computer(brand: "MacBook Pro", specs: .init(cpu: "M2", ram: 16))
print("Brand: \(mac.brand), CPU: \(mac.specs.cpu), RAM: \(mac.specs.ram)GB")

// MARK: - Extensions

extension Int {
    var squared: Int {
        return self * self
    }
}

let number = 5
print("The square of \(number) is \(number.squared)")

// MARK: - Initialization and Deinitialization

class FileHandler {
    init() {
        print("File opened.")
    }

    func readData() {
        print("Reading data...")
    }

    deinit {
        print("File closed.")
    }
}

func loadFile() {
    let file = FileHandler()
    file.readData()
}

loadFile() // Deinitializer called when exiting scope

// MARK: - Access Control

class BankAccount {
    private var balance: Double = 0

    public func deposit(amount: Double) {
        balance += amount
    }

    public func getBalance() -> Double {
        return balance
    }
}

let account = BankAccount()
account.deposit(amount: 1000)
print("Balance: \(account.getBalance())")
