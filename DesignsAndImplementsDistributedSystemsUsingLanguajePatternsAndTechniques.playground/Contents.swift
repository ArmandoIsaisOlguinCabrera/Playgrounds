import Foundation

// Simulate a remote service that responds asynchronously and may fail
actor RemoteService {
    let name: String

    init(name: String) {
        self.name = name
    }

    // Fetch data with random delay and possible failure
    func fetchData() async throws -> String {
        let delay = UInt64.random(in: 500_000_000...1_500_000_000) // 0.5 - 1.5s delay
        try await Task.sleep(nanoseconds: delay)

        if Bool.random() { // Random failure simulation
            throw URLError(.timedOut)
        }
        return "Data from \(name)"
    }
}

// Coordinates multiple remote services concurrently and safely collects results
actor DistributedSystemCoordinator {
    private var results: [String] = []

    // Fetch from all services concurrently using a task group
    func fetchFromAllServices() async {
        let services = [
            RemoteService(name: "Service A"),
            RemoteService(name: "Service B"),
            RemoteService(name: "Service C")
        ]

        await withTaskGroup(of: String?.self) { group in
            for service in services {
                group.addTask {
                    do {
                        return try await service.fetchData()
                    } catch {
                        return "⚠️ Error in \(service.name)"
                    }
                }
            }

            for await result in group {
                if let result = result {
                    results.append(result)
                }
            }
        }
    }

    // Display all collected results
    func showResults() {
        print("📦 Collected Results:")
        for r in results {
            print("→ \(r)")
        }
    }
}

// Entry point of the Playground (or executable target)
@main
struct Main {
    static func main() async {
        let coordinator = DistributedSystemCoordinator()
        print("🌐 Starting distributed service requests...\n")
        await coordinator.fetchFromAllServices()
        await coordinator.showResults()
    }
}
