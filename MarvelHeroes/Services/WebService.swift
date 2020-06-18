import Foundation

class WebService {
  let httpClient: HttpClient

  init(httpClient: HttpClient) {
    self.httpClient = httpClient
  }

  func getHeroes(completion: @escaping (([Hero]?) -> Void)) {
    guard let url = URL(string: Constants.apiURL + Constants.heroesEndpoint) else {
      fatalError("Url is not correct")
    }
    httpClient.get(url: url) { data, error in
      guard let data = data, error == nil else {
        DispatchQueue.main.async {
          completion(nil)
        }
        return
      }
      do {
        let heroes = try JSONDecoder().decode(APIResponse.self, from: data)
        DispatchQueue.main.async {
          completion(heroes.data.results)
        }
      } catch {
        print(error)
      }
    }
  }
}
