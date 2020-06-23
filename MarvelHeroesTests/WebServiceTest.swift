import XCTest

class WebServiceTest: XCTestCase {
  private var webService: WebService!
  private let session = MockURLSession()

  override func setUp() {
    super.setUp()
    let httpClient = HttpClient(session: session)
    webService = WebService(httpClient: httpClient)
  }

  func testGetHeroesResponseIsNil() throws {
    webService.getHeroes { _, errors in
      XCTAssertEqual(errors, .noNetwork)
    }
  }

  func testGetHeroesResponseHasHeroes() throws {
    let heroData = MockResponse().mockContentData
    session.nextData = heroData
    let asyncWebServiceExpectation = expectation(description: "Async WebService started")
    webService.getHeroes { heroes, errors in
      guard let hero = heroes?.first else { return }
      XCTAssertEqual(hero.name, "3-D Man")
      XCTAssertNil(errors)
      asyncWebServiceExpectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
