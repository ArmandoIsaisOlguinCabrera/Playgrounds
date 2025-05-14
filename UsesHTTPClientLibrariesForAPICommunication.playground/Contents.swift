import UIKit
import Alamofire
import Network

// MARK: - Basic API Client Configuration

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}

// Define a shared session configuration with timeout
let session = Session(configuration: {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 30 // Timeout in seconds
    return config
}())

// MARK: - HTTP GET Request Example
func fetchPosts() {
    let url = "https://jsonplaceholder.typicode.com/posts"
    
    session.request(url, method: .get)
        .validate()
        .responseDecodable(of: [Post].self) { response in
            switch response.result {
            case .success(let posts):
                print("✅ Posts fetched successfully:")
                posts.prefix(3).forEach { print("• \($0.title)") }
            case .failure(let error):
                print("❌ Error fetching posts: \(error.localizedDescription)")
            }
        }
}

// MARK: - HTTP POST Request Example
func createPost() {
    let url = "https://jsonplaceholder.typicode.com/posts"
    let newPost = Post(id: 101, title: "New Post", body: "This is a test post.")
    
    session.request(url, method: .post, parameters: newPost, encoder: JSONParameterEncoder.default)
        .validate()
        .responseDecodable(of: Post.self) { response in
            switch response.result {
            case .success(let createdPost):
                print("✅ Post created: \(createdPost)")
            case .failure(let error):
                print("❌ Error creating post: \(error.localizedDescription)")
            }
        }
}

// MARK: - Network Monitoring
let monitor = NWPathMonitor()
let queue = DispatchQueue(label: "NetworkMonitor")

monitor.pathUpdateHandler = { path in
    if path.status == .satisfied {
        print("📶 Network is available")
        fetchPosts()
        createPost()
    } else {
        print("📴 Network is unavailable")
    }
}
monitor.start(queue: queue)
