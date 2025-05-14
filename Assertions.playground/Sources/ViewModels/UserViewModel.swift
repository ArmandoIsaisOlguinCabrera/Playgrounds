import Foundation

class UserViewModel {
    private let service: UserService
    var userName: String?

    init(service: UserService) {
        self.service = service
    }

    func loadUser() {
        service.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.userName = user.name
            case .failure:
                self?.userName = "Error"
            }
        }
    }
}
