import XCTest
@testable import AssertionsPlayground

final class UserViewModelTests: XCTestCase {

    func testLoadUserSuccess() {
        let mockService = MockUserService()
        let viewModel = UserViewModel(service: mockService)
        
        viewModel.loadUser()
        
        // No async en este mock, así que es inmediato
        XCTAssertEqual(viewModel.userName, "Alice", "El nombre del usuario debería ser 'Alice'")
    }

    func testLoadUserFailure() {
        let mockService = MockUserService()
        mockService.shouldReturnError = true
        let viewModel = UserViewModel(service: mockService)
        
        viewModel.loadUser()
        
        XCTAssertEqual(viewModel.userName, "Error", "El nombre del usuario debería ser 'Error' en caso de fallo")
    }

    func testAsyncLoadUser() {
        let expectation = self.expectation(description: "Esperando respuesta de usuario")
        let asyncService = AsyncMockUserService()
        let viewModel = UserViewModel(service: asyncService)

        viewModel.loadUser()

        // Esperamos que se actualice después del delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            XCTAssertEqual(viewModel.userName, "Bob", "El nombre del usuario debería ser 'Bob'")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
