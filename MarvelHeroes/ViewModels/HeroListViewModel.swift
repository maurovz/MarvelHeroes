import Foundation

class HeroListViewModel: ObservableObject {
  @Published var heroes: [HeroViewModel] = [HeroViewModel]()
  private let webService: WebService

  init() {
    webService = WebService(httpClient: HttpClient(session: URLSession(configuration: .default)))
    fetchHeroes()
  }

  func fetchHeroes() {
    webService.getHeroes { heroes in
      guard let heroes = heroes else { return }
      self.heroes = heroes.map(HeroViewModel.init)
    }
  }
}
