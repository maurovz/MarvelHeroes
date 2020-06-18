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
    webService.getHeroes { hero in
      XCTAssertNil(hero)
    }
  }

  func testGetHeroesResponseHasHeroes() throws {
    let heroData = MockResponse().mockContentData
    session.nextData = heroData
    let asyncWebServiceExpectation = expectation(description: "Async WebService started")
    webService.getHeroes { heroes in
      guard let hero = heroes?.first else { return }
      XCTAssertEqual(hero.name, "3-D Man")
      asyncWebServiceExpectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
