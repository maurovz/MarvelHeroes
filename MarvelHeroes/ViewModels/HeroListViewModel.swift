import Foundation

class HeroListViewModel: ObservableObject {
  @Published var heroes: [HeroViewModel] = [HeroViewModel]()
  
  init() {
    fetchHeroes()
  }
  
  func fetchHeroes() {
    WebService().getHeroes { heroes in
      guard let heroes = heroes else { return }
      self.heroes = heroes.map(HeroViewModel.init)
    }
  }
}
