import XCTest
@testable import AI_Edu

final class AuthRepositoryTests: XCTestCase {
    var sut: AuthRepository!
    
    override func setUp() {
        super.setUp()
        sut = AuthRepository()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testRegisterSuccess() async throws {
        // Given
        let expectation = expectation(description: "Register success")
        let login = "SomeNewPerson"
        let email = "SomeNewPerson@example.com"
        let password = "password123"
        
        // When
        do {
            try await sut.register(login: login, email: email, password: password)
            
            // Then
            expectation.fulfill()
        } catch {
            XCTFail("Failed to register: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testSignInSuccess() async throws {
        // Given
        let expectation = expectation(description: "Sign in success")
        let login = "SomeNewPerson"
        let password = "password123"
        
        // When
        do {
            let token = try await sut.signIn(login: login, password: password)
            
            // Then
            XCTAssertFalse(token.isEmpty, "Token should not be empty")
            expectation.fulfill()
        } catch {
            XCTFail("Failed to sign in: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testRegisterInvalidCredentials() async {
        // Given
        let expectation = expectation(description: "Register invalid credentials")
        let login = ""
        let email = "invalid-email"
        let password = "short"
        
        // When
        do {
            try await sut.register(login: login, email: email, password: password)
            XCTFail("Should throw error for invalid credentials")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError, "Error should be NetworkError")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testSignInInvalidCredentials() async {
        // Given
        let expectation = expectation(description: "Sign in invalid credentials")
        let login = "nonexistent"
        let password = "wrongpassword"
        
        // When
        do {
            _ = try await sut.signIn(login: login, password: password)
            XCTFail("Should throw error for invalid credentials")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError, "Error should be NetworkError")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testRegisterNetworkError() async {
        // Given
        let expectation = expectation(description: "Register network error")
        let login = "SomeNewPerson"
        let email = "SomeNewPerson@example.com"
        let password = "password123"
        
        // When
        do {
            try await sut.register(login: login, email: email, password: password)
            XCTFail("Should throw network error")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError, "Error should be NetworkError")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testSignInNetworkError() async {
        // Given
        let expectation = expectation(description: "Sign in network error")
        let login = "testuser"
        let password = "password123"
        
        // When
        do {
            _ = try await sut.signIn(login: login, password: password)
            XCTFail("Should throw network error")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError, "Error should be NetworkError")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
} 
