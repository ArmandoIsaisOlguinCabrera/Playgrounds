import Foundation

// MARK: - 1. Limit concurrency with OperationQueue
let limitedQueue = OperationQueue()
limitedQueue.maxConcurrentOperationCount = 2 // Only 2 tasks can run simultaneously

for i in 1...5 {
    limitedQueue.addOperation {
        print("🔄 Starting task \(i)")
        Thread.sleep(forTimeInterval: 1) // Simulate a task
        print("✅ Finished task \(i)")
    }
}

// MARK: - 2. Wait for a group of async tasks to complete using DispatchGroup
let group = DispatchGroup()

DispatchQueue.global().async(group: group) {
    print("📦 Task A started")
    sleep(2) // Simulate work
    print("📦 Task A done")
}

DispatchQueue.global().async(group: group) {
    print("📦 Task B started")
    sleep(1) // Simulate work
    print("📦 Task B done")
}

// Notify the main queue when all group tasks have finished
group.notify(queue: .main) {
    print("🚀 All tasks in the group are completed")
}

// MARK: - 3. Create task dependencies using OperationQueue and Operation
let dependencyQueue = OperationQueue()

let prepareOp = BlockOperation {
    print("🔧 Op1: Preparing resources")
    sleep(1)
}

let processOp = BlockOperation {
    print("🛠 Op2: Processing data")
    sleep(1)
}

let finishOp = BlockOperation {
    print("🎉 Op3: Finalizing process")
}

// Define dependencies: each task waits for the previous one
processOp.addDependency(prepareOp) // Op2 waits for Op1
finishOp.addDependency(processOp)  // Op3 waits for Op2

// Add operations to the queue
dependencyQueue.addOperations([prepareOp, processOp, finishOp], waitUntilFinished: false)

// Keep Playground running to see all output
RunLoop.main.run(until: Date(timeIntervalSinceNow: 7))
