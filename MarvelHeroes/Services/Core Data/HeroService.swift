import Foundation

struct HeroService {
  func saveHeroesToCoreData(heroes: [Hero]) {
    let context = CoreDataStack.persistentContainer.viewContext
    for hero in heroes {
      let heroDetails = HeroDetails(context: context)
      heroDetails.name = hero.name
      heroDetails.heroDescription = hero.description
      CoreDataStack.saveContext()
    }
  }

  func loadHeroesFromCoreData() -> [HeroDetails] {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      return try context.fetch(HeroDetails.fetchRequest())
    } catch {
      return []
    }
  }
}
