import Foundation

// MARK: - Command Pattern

// Objective: The Command Pattern allows encapsulating a request as an object, which allows parameterizing clients with different requests and operations.
// How it works: Command objects (LightOnCommand, LightOffCommand) encapsulate the actions of turning on and off the light. The remote control (RemoteControl) can execute these commands without knowing how the actions are implemented.

protocol Command {
    func execute()
}

class Light {
    func turnOn() {
        print("The light is on.")
    }
    
    func turnOff() {
        print("The light is off.")
    }
}

class LightOnCommand: Command {
    private var light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOn()
    }
}

class LightOffCommand: Command {
    private var light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOff()
    }
}

class RemoteControl {
    private var command: Command?
    
    func setCommand(command: Command) {
        self.command = command
    }
    
    func pressButton() {
        command?.execute()
    }
}

// Using the Command Pattern
let light = Light()  // Create a light
let lightOn = LightOnCommand(light: light)  // Create the command to turn it on
let lightOff = LightOffCommand(light: light)  // Create the command to turn it off

let remote = RemoteControl()  // Create a remote control

// Assign the command to the remote control and press the button
remote.setCommand(command: lightOn)
remote.pressButton()  // The light is on.

remote.setCommand(command: lightOff)
remote.pressButton()  // The light is off.

print("\n")  // Blank line to separate patterns

// MARK: - Strategy Pattern

// Objective: The Strategy Pattern allows changing an object's behavior at runtime by choosing a strategy.
// How it works: The behavior of the calculator is delegated to a strategy that performs a mathematical operation. The strategy can be changed at any time without modifying the calculator code.

protocol Strategy {
    func execute(a: Int, b: Int) -> Int
}

class AddStrategy: Strategy {
    func execute(a: Int, b: Int) -> Int {
        return a + b
    }
}

class SubtractStrategy: Strategy {
    func execute(a: Int, b: Int) -> Int {
        return a - b
    }
}

class Calculator {
    private var strategy: Strategy
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func setStrategy(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func calculate(a: Int, b: Int) -> Int {
        return strategy.execute(a: a, b: b)
    }
}

// Using the Strategy Pattern
let calculator = Calculator(strategy: AddStrategy())  // Initialize with the addition strategy
print("Addition result: \(calculator.calculate(a: 5, b: 3))")  // 8

calculator.setStrategy(strategy: SubtractStrategy())  // Change the strategy to subtraction
print("Subtraction result: \(calculator.calculate(a: 5, b: 3))")  // 2

print("\n")  // Blank line to separate patterns

// MARK: - Observer Pattern

// Objective: The Observer Pattern allows an object (subject) to notify other objects (observers) when its state changes.
// How it works: The subject maintains a list of observers interested in its state. When the state changes, the subject notifies all registered observers.

protocol Observer: AnyObject {
    func update(state: String)
}

class ConcreteObserver: Observer {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func update(state: String) {
        print("\(name) has been notified of the new state: \(state)")
    }
}

protocol Subject {
    func addObserver(observer: Observer)
    func removeObserver(observer: Observer)
    func notifyObservers()
}

class ConcreteSubject: Subject {
    private var observers = [Observer]()
    private var state: String?
    
    func addObserver(observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(observer: Observer) {
        observers = observers.filter { $0 !== observer }
    }
    
    func notifyObservers() {
        guard let state = state else { return }
        observers.forEach { $0.update(state: state) }
    }
    
    func getState() -> String? {
        return state
    }
    
    func setState(state: String) {
        self.state = state
        notifyObservers()  // Notify observers whenever the state changes.
    }
}

// Using the Observer Pattern
let subject = ConcreteSubject()
let observer1 = ConcreteObserver(name: "Observer 1")
let observer2 = ConcreteObserver(name: "Observer 2")

subject.addObserver(observer: observer1)
subject.addObserver(observer: observer2)

subject.setState(state: "New state 1")  // Notifies all observers

subject.removeObserver(observer: observer1)
subject.setState(state: "New state 2")  // Notifies only observer2
