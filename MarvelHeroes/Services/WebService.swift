import Foundation

class WebService {
  let httpClient: HttpClient

  init(httpClient: HttpClient = HttpClient(session: URLSession(configuration: .default))) {
    self.httpClient = httpClient
  }

  enum APIError: String, Error {
    case noNetwork = "Network error"
    case decodingError = "Error decoding response"
  }

  typealias GetHeroesCompleteClosure = ([Hero]?, APIError?) -> Void

  func getHeroes(completion: @escaping GetHeroesCompleteClosure) {
    guard let url = URL(string: Constants.apiURL + Constants.heroesEndpoint) else {
      fatalError("Url is not correct")
    }
    httpClient.get(url: url) { data, error in
      guard let data = data, error == nil else {
        DispatchQueue.main.async {
          completion(nil, .noNetwork)
        }
        return
      }
      do {
        let heroes = try JSONDecoder().decode(APIResponse.self, from: data)
        DispatchQueue.main.async {
          completion(heroes.data.results, nil)
        }
      } catch {
        completion(nil, .decodingError)
      }
    }
  }
}
