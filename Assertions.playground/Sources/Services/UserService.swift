import Foundation

protocol UserService {
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void)
}

class AsyncMockUserService: UserService {
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(.success(User(name: "Bob")))
        }
    }
}

class MockUserService: UserService {
    var shouldReturnError = false

    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        } else {
            completion(.success(User(name: "Alice")))
        }
    }
}
