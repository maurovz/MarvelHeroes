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

  func getHeroes(completion: @escaping ([Hero]?, APIError?) -> Void) {
    guard let url = URL(string: Constants.apiURL + Constants.heroesEndpoint) else {
      fatalError(Constants.urlError)
    }
    httpClient.get(url: url) { data, error in
      guard let data = data, error == nil else {
        DispatchQueue.main.async {
          completion(nil, .noNetwork)
        }
        return
      }
      do {
        let heroes = try JSONDecoder().decode(HeroAPIResponse.self, from: data)
        DispatchQueue.main.async {
          completion(heroes.data.results, nil)
        }
      } catch {
        completion(nil, .decodingError)
      }
    }
  }

  func getComics(completion: @escaping ([Comic]?, APIError?) -> Void) {
    guard let url = URL(string: Constants.apiURL + Constants.comicsEndpoint) else {
      fatalError(Constants.urlError)
    }
    httpClient.get(url: url) { data, error in
      guard let data = data, error == nil else {
        DispatchQueue.main.async {
          completion(nil, .noNetwork)
        }
        return
      }
      do {
        let comics = try JSONDecoder().decode(ComicAPIResponse.self, from: data)
        DispatchQueue.main.async {
          completion(comics.data.results, nil)
        }
      } catch {
        completion(nil, .decodingError)
      }
    }
  }
}
