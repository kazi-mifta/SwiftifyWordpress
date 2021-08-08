import XCTest
@testable import iOSPress

final class iOSPressTests: XCTestCase {
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
        let expectation = XCTestExpectation(description: "We should wait 20 sec")
        
        NetworkManager.request(baseUrl: "gadgetanalysis.com") { [weak expectation]
            (result: Result<[Post], Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 10,"For now the request returns 10 post")
                expectation?.fulfill()
            case .failure(_):
                break
            }
        }
        self.wait(for: [expectation], timeout: 20)
    }
}
