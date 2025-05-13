import Foundation

enum NetworkError: Error {
    case noData
    case invalidResponse
    case failedRequest
}

struct DataFetcher {

    // Mark the completion closure as @Sendable to ensure thread-safety
    func fetchData(from url: String, completion: @escaping @Sendable (Result<String, NetworkError>) -> Void) {
        // Simulating a network process with a small delay
        DispatchQueue.global().async { [completion] in  // Capture completion safely
            sleep(2) // Simulates response wait time

            if url == "https://valid.url" {
                completion(.success("Data successfully fetched"))
            } else {
                completion(.failure(.failedRequest))
            }
        }
    }

    // Using exception handling and defer
    func processData(from url: String) {
        do {
            let data = try getData(from: url)
            print("Processed Data: \(data)")
        } catch let error as NetworkError {
            print("Error fetching data: \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    // Function that throws an error if the URL is invalid
    func getData(from url: String) throws -> String {
        guard !url.isEmpty else {
            throw NetworkError.noData
        }
        
        // Simulating an operation that may fail
        if url == "https://invalid.url" {
            throw NetworkError.invalidResponse
        }
        
        return "Data processed from \(url)"
    }

    // Using defer to clean up resources after an operation
    func performTask() {
        var resourceOpened = false
        
        // Ensure that the resource is closed regardless of the outcome
        defer {
            if resourceOpened {
                print("Resource closed")
            }
        }
        
        // Open the resource
        resourceOpened = true
        print("Resource opened")
        
        // Task logic
        // If an error occurs, we exit early, but the defer block ensures resource cleanup
        if true {
            print("An error occurred")
            return
        }
        
        // If everything goes well, the defer block will execute at the end
    }
}
