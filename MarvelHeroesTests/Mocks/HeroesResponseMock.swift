import Foundation

class MockResponse {
  var mockContentData: Data {
    return getData(name: "heroesResponseMock")
  }

  func getData(name: String, withExtension: String = "json") -> Data {
    let bundle = Bundle(for: type(of: self))
    guard let fileUrl = bundle.url(forResource: name, withExtension: withExtension) else {
      fatalError("MockResponse json file doesn't exists")
    }
    do {
      let data = try Data(contentsOf: fileUrl)
      return data
    } catch {
      fatalError("Error loading MockResponse json file")
    }
  }
}
