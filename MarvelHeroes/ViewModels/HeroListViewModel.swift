import Foundation
import CoreData

class HeroListViewModel: ObservableObject {
  @Published var heroes: [HeroDetailsViewModel] = [HeroDetailsViewModel]()
  @Published var isLoadingHeroes = false
  private var webService: WebService

  init(webService: WebService = WebService()) {
    self.webService = webService
    syncHeroes()
    syncComics()
  }

  private func syncHeroes() {
    webService.getHeroes { heroes, error in
      if error == .noNetwork {
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

  private func syncComics() {
    webService.getComics { comics, error in
      if error == .noNetwork {
        // fetch from core data
      } else {
        guard let comics = comics else { return }

      }
    }
  }

  private func saveHeroesToCoreData(heroService: HeroService, heroes: [Hero]) {
    heroService.saveHeroesToCoreData(heroes: heroes)
  }

  private func fetchHeroesFromCoreData(heroService: HeroService) -> [HeroDetailsViewModel] {
    let fetchedHeroes = heroService.loadHeroesFromCoreData()
    return fetchedHeroes.map(HeroDetailsViewModel.init)
  }

  private func deleteOldHeroesFromCoreData(heroService: HeroService) -> Bool {
    return heroService.deleteEntityFromCoreData(entity: "HeroDetails")
  }
}
