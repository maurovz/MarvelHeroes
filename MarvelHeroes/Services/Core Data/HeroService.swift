import Foundation
import CoreData

struct HeroService {
  func saveHeroesToCoreData(heroes: [Hero]) {
    let context = CoreDataStack.persistentContainer.viewContext
    for hero in heroes where !hero.description.isEmpty {
      let heroDetails = HeroDetails(context: context)
      heroDetails.name = hero.name
      heroDetails.heroDescription = hero.description
      heroDetails.thumbnailURL = hero.thumbnail.path + "." + hero.thumbnail.imageExtension
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

  func deleteEntityFromCoreData(entity: String) -> Bool {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
      let request = NSBatchDeleteRequest(fetchRequest: fetch)
      try context.execute(request)
      return true
    } catch {
      return false
    }
  }
}
