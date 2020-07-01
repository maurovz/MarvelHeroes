import Foundation
import CoreData

class HeroListViewModel: ObservableObject {
  @Published var heroes: [HeroDetailsViewModel] = [HeroDetailsViewModel]()
  @Published var comics: [ComicDetailsViewModel] = [ComicDetailsViewModel]()
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
        self.heroes = self.fetchHeroesFromCoreData(coreDataServices: CoreDataServices())
      } else {
        guard let heroes = heroes else { return }
        if self.deleteSavedHeroesFromCoreData(coreDataServices: CoreDataServices()) {
          self.saveHeroesToCoreData(coreDataServices: CoreDataServices(), heroes: heroes)
          self.heroes = self.fetchHeroesFromCoreData(coreDataServices: CoreDataServices())
        }
      }
    }
  }

  private func syncComics() {
    webService.getComics { comics, error in
      if error == .noNetwork {
        self.comics = self.fetchComicsFromCoreData(coreDataServices: CoreDataServices())
      } else {
        guard let comics = comics else { return }
        if self.deleteSavedComicsFromCoreData(coreDataServices: CoreDataServices()) {
          self.saveComicsToCoreData(coreDataServices: CoreDataServices(), comics: comics)
          self.comics = self.fetchComicsFromCoreData(coreDataServices: CoreDataServices())
        }
      }
    }
  }

  private func saveHeroesToCoreData(coreDataServices: CoreDataServices, heroes: [Hero]) {
    coreDataServices.saveHeroesToCoreData(heroes: heroes)
  }

  private func saveComicsToCoreData(coreDataServices: CoreDataServices, comics: [Comic]) {
    coreDataServices.saveComicsToCoreData(comics: comics)
  }

  private func fetchHeroesFromCoreData(coreDataServices: CoreDataServices) -> [HeroDetailsViewModel] {
    let fetchedHeroes = coreDataServices.loadHeroesFromCoreData()
    return fetchedHeroes.map(HeroDetailsViewModel.init)
  }

  private func fetchComicsFromCoreData(coreDataServices: CoreDataServices) -> [ComicDetailsViewModel] {
    let fetchedComics = coreDataServices.loadComicsFromCoreData()
    return fetchedComics.map(ComicDetailsViewModel.init)
  }

  private func deleteSavedHeroesFromCoreData(coreDataServices: CoreDataServices) -> Bool {
    let heroDetailEntityName = "HeroDetails"
    return coreDataServices.deleteEntityFromCoreData(entity: heroDetailEntityName)
  }

  private func deleteSavedComicsFromCoreData(coreDataServices: CoreDataServices) -> Bool {
    let comicDetailEntityName = "ComicDetails"
    return coreDataServices.deleteEntityFromCoreData(entity: comicDetailEntityName)
  }
}
