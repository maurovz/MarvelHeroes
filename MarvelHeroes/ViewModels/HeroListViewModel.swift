import Foundation
import CoreData

class HeroListViewModel: ObservableObject {
  @Published var heroes: [HeroDetailsViewModel] = [HeroDetailsViewModel]()
  @Published var isLoadingHeroes = false
  private var webService: WebService

  init(webService: WebService = WebService()) {
    self.webService = webService
    syncHeroes()
  }

  func syncHeroes() {
    isLoadingHeroes = true
    webService.getHeroes { heroes, errors in
      self.isLoadingHeroes = false
      if errors == .noNetwork {
        self.heroes = self.fetchHeroesFromCoreData(heroService: HeroService())
      } else {
        guard let heroes = heroes else { return }
        if self.deleteOldHeroesFromCoreData(heroService: HeroService()) {
          self.saveHeroesToCoreData(heroService: HeroService(), heroes: heroes)
          self.heroes = self.fetchHeroesFromCoreData(heroService: HeroService())
        }
      }
    }
  }

  func saveHeroesToCoreData(heroService: HeroService, heroes: [Hero]) {
    heroService.saveHeroesToCoreData(heroes: heroes)
  }

  func fetchHeroesFromCoreData(heroService: HeroService) -> [HeroDetailsViewModel] {
    let fetchedHeroes = heroService.loadHeroesFromCoreData()
    return fetchedHeroes.map(HeroDetailsViewModel.init)
  }

  func deleteOldHeroesFromCoreData(heroService: HeroService) -> Bool {
    return heroService.deleteOldHeroesFromCoreData()
  }
}
