import Foundation

// MARK: - 1. Sync vs Async Calls

func doSyncWork() {
    print("Start sync work")
    sleep(2)
    print("End sync work")
}

func doAsyncWork() {
    print("Start async work")
    DispatchQueue.global().async {
        sleep(2)
        print("End async work")
    }
}

// MARK: - 2. DispatchQueue and OperationQueue

func usingDispatchQueue() {
    DispatchQueue.global().async {
        print("Executed in background thread")
        DispatchQueue.main.async {
            print("Back on main thread")
        }
    }
}

func usingOperationQueue() {
    let queue = OperationQueue()
    queue.addOperation {
        print("Operation in background")
    }
}

// MARK: - 3. Completion Handlers

func fetchData(completion: @escaping @Sendable (Result<String, Error>) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
        let success = true
        if success {
            completion(.success("Downloaded data"))
        } else {
            completion(.failure(NSError(domain: "Error", code: 1)))
        }
    }
}

// MARK: - 4. Async Sequences

struct MyAsyncSequence: AsyncSequence {
    typealias Element = Int

    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1
        mutating func next() async -> Int? {
            guard current <= 3 else { return nil }
            let value = current
            current += 1
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            return value
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }
}

// MARK: - 5. async let

func fetchName() async -> String {
    return "Armando"
}

func fetchAge() async -> Int {
    return 30
}

func runAsyncLet() async {
    async let name = fetchName()
    async let age = fetchAge()
    let (userName, userAge) = await (name, age)
    print("Name: \(userName), Age: \(userAge)")
}

// MARK: - 6. Tasks and TaskGroup

func useTaskGroup() async {
    await withTaskGroup(of: Int.self) { group in
        for i in 1...3 {
            group.addTask {
                return i * 2
            }
        }

        for await result in group {
            print("Result: \(result)")
        }
    }
}

// MARK: - Run Examples

doSyncWork()
doAsyncWork()
usingDispatchQueue()
usingOperationQueue()
fetchData { result in
    switch result {
    case .success(let data):
        print(data)
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}

Task {
    for await value in MyAsyncSequence() {
        print("Received value: \(value)")
    }

    await runAsyncLet()
    await useTaskGroup()
}
