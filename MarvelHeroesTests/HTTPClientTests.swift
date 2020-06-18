import XCTest
@testable import MarvelHeroes

class HTTPClientTests: XCTestCase {
  var httpClient: HttpClient!
  let session = MockURLSession()

  override func setUp() {
    super.setUp()
    httpClient = HttpClient(session: session)
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_get_request_with_data() {
    guard let url = URL(string: "https://TestURL") else {
      fatalError("URL string is empty")
    }
    session.nextData = Data()
    httpClient.get(url: url) { (data, error) in
      XCTAssertNotNil(data)
      XCTAssertNil(error)
    }
  }
}
