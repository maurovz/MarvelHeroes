import Foundation

class WebService {
  func getHeroes(completion: @escaping (([Hero]?) -> Void)) {
    guard let url = URL(string: Constants.apiURL + Constants.heroesEndpoint) else {
      fatalError("Url is not correct")
    }
    URLSession.shared.dataTask(with: url) { data, _, error in
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
    }.resume()
  }
}
