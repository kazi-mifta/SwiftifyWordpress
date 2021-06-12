import XCTest
@testable import iOSPress

final class iOSPressTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(iOSPress().text, "Hello, World!")
    }
    
    func testJSONMapping() throws {
        
        let json = """
        {
            "id":37784,
            "title":{
                "rendered":"Top 15 Stunning Examples of the WordPress Elementor Theme in Action"
            },
            "date":"2021-06-07T08:23:18"
        }
        """
        guard let jsonData = json.data(using: .utf8) else{
            XCTFail("Failed to read Data from JSON")
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.standardT)
        
        guard let post = try? decoder.decode(Post.self, from: jsonData) else {
            XCTFail("Failed to decode from data")
            return
        }
        
        XCTAssertEqual(post.id,37784)
        XCTAssertEqual(post.title?.rendered,"Top 15 Stunning Examples of the WordPress Elementor Theme in Action")
        XCTAssertEqual(post.link, nil)
        
    }
    
    func testAsyncNetworkCall() {
        let expectation = XCTestExpectation(description: "We should wait 10 sec")
        
        NetworkManager.request(baseUrl: "winningwp.com") { [weak expectation]
            (result: Result<[Post], Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 20,"For now the request returns 20 post")
                expectation?.fulfill()
            case .failure(_):
                break
            }
        }
        self.wait(for: [expectation], timeout: 10)
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
