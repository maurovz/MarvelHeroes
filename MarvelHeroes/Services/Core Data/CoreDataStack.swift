import Foundation
import CoreData

class CoreDataStack {
  static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MarvelHeroes")
    container.loadPersistentStores { (_, error) in
      if let error = error as NSError? {
        fatalError("Unknown database error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  class func saveContext () {
    let context = CoreDataStack.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unknown database error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
