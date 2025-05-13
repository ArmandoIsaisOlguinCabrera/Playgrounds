import Foundation

// MARK: - 1. Mechanisms for Concurrent Task Execution

print("1️⃣ Mechanisms for concurrent task execution")

// Grand Central Dispatch (GCD)
DispatchQueue.global().async {
    print("🔹 GCD Task running in background")
}

// OperationQueue
let operationQueue = OperationQueue()
operationQueue.addOperation {
    print("🔹 OperationQueue executing task")
}

// Swift Concurrency
Task {
    print("🔹 Swift Concurrency using Task")
}

// Wait to let async tasks print
sleep(1)


// MARK: - 2. Serial vs Concurrent Queues

print("\n2️⃣ Serial vs Concurrent Queues")

let serialQueue = DispatchQueue(label: "com.example.serial")
let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)

print("🔸 Serial Queue:")
serialQueue.async {
    print("Task 1")
}
serialQueue.async {
    print("Task 2")
}

print("🔸 Concurrent Queue:")
concurrentQueue.async {
    print("Task A")
}
concurrentQueue.async {
    print("Task B")
}

sleep(1)


// MARK: - 3. Quality of Service (QoS)

print("\n3️⃣ Quality of Service (QoS)")

DispatchQueue.global(qos: .userInitiated).async {
    print("QoS: userInitiated (high priority)")
}

DispatchQueue.global(qos: .background).async {
    print("QoS: background (low priority)")
}

sleep(1)


// MARK: - 4. Pros and Cons: GCD vs Operation vs Swift Concurrency

print("\n4️⃣ Comparing concurrency mechanisms")

// GCD - No cancellation, simple API
let gcdQueue = DispatchQueue.global()
gcdQueue.async {
    print("GCD - simple task without cancellation")
}

// Operation - Supports cancellation and dependencies
let op = BlockOperation {
    print("Operation executed")
}
operationQueue.addOperation(op)

// Swift Concurrency - modern, cancelable, structured
let swiftTask = Task {
    print("Swift Task executed")
}

sleep(1)


// MARK: - 5. What is a Queue?

print("\n5️⃣ What is a Queue?")

let myQueue = DispatchQueue(label: "com.myapp.serial")
myQueue.async {
    print("Running on a custom serial queue")
}

sleep(1)


// MARK: - 6. Queue vs Thread

print("\n6️⃣ Queue vs Thread")

DispatchQueue.global().async {
    print("Running on thread: \(Thread.current)")
}

sleep(1)


// MARK: - 7. How to terminate execution

print("\n7️⃣ Terminating and canceling tasks")

// Operation cancel
let cancellableOperation = BlockOperation {
    if !cancellableOperation.isCancelled {
        print("✅ Operation not cancelled")
    } else {
        print("❌ Operation was cancelled")
    }
}
cancellableOperation.cancel()
operationQueue.addOperation(cancellableOperation)

// Swift Task cancel
let cancelableTask = Task {
    for i in 1...3 {
        if Task.isCancelled {
            print("❌ Swift Task was cancelled")
            return
        }
        print("✅ Swift Task working: \(i)")
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
    }
}
cancelableTask.cancel()

sleep(2)

print("\n✅ End of Playground")
