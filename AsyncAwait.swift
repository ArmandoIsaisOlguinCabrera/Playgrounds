import Foundation

// MARK: - Traditional completion handler (pre-Swift 5.5)
func fetchDataOld(completion: @escaping (String) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
        completion("✅ Data fetched using completion handler")
    }
}

// MARK: - Modern async/await (Swift 5.5+)
func fetchDataNew() async -> String {
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    return "🚀 Data fetched using async/await"
}

// MARK: - Evaluation of integration

// 1. Compatibility Check
if #available(iOS 15.0, macOS 12.0, *) {
    // Using new feature
    Task {
        let result = await fetchDataNew()
        print(result)
    }
} else {
    // Fallback for older systems
    fetchDataOld { result in
        print(result)
    }
}

// 2. Benefit Analysis:
// - async/await leads to cleaner code
// - easier to read and maintain
// - removes deeply nested closures

// 3. Risk Consideration:
// - Only available in iOS 15+
// - Might require refactoring many APIs
// - Compatibility wrappers may be necessary

// Playground stays alive to show async output
RunLoop.main.run(until: Date(timeIntervalSinceNow: 3))
