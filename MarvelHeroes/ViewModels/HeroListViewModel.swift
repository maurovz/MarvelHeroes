import Foundation
import CoreData

class HeroListViewModel: ObservableObject {
  @Published var heroes: [HeroDetailsViewModel] = [HeroDetailsViewModel]()
  private var webService: WebService

  init(webService: WebService = WebService()) {
    self.webService = webService
    syncHeroes()
  }

  func syncHeroes() {
    webService.getHeroes { heroes in
      guard let heroes = heroes else { return }
      self.saveHeroesToCoreData(heroService: HeroService(), heroes: heroes)
      self.heroes = self.fetchHeroesFromCoreData(heroService: HeroService())
    }
  }

  func saveHeroesToCoreData(heroService: HeroService, heroes: [Hero]) {
    heroService.saveHeroesToCoreData(heroes: heroes)
  }

  func fetchHeroesFromCoreData(heroService: HeroService) -> [HeroDetailsViewModel] {
    let fetchedHeroes = heroService.loadHeroesFromCoreData()
    return fetchedHeroes.map(HeroDetailsViewModel.init)
  }
}
