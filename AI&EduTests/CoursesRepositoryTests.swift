import XCTest
@testable import AI_Edu

final class CoursesRepositoryTests: XCTestCase {
    var sut: CoursesRepository!
    
    override func setUp() {
        super.setUp()
        sut = CoursesRepository()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetCoursesSuccess() async throws {
        // Given
        let expectation = expectation(description: "Get courses")
        
        // When
        do {
            let courses = try await sut.getCourses()
            
            // Then
            XCTAssertFalse(courses.isEmpty, "Courses array should not be empty")
            expectation.fulfill()
        } catch {
            XCTFail("Failed to get courses: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testGetCourseByIdSuccess() async throws {
        // Given
        let expectation = expectation(description: "Get course items")
        let courseId = 1
        
        // When
        do {
            let items = try await sut.getCourseById(courseId: courseId)
            
            // Then
            XCTAssertFalse(items.isEmpty, "Course items array should not be empty")
            expectation.fulfill()
        } catch {
            XCTFail("Failed to get course items: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testGetCoursesNetworkError() async {
        // Given
        let expectation = expectation(description: "Network error")
        
        // When
        do {
            _ = try await sut.getCourses()
            XCTFail("Should throw network error")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError, "Error should be NetworkError")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
} 