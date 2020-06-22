import SwiftUI

class HeroViewModel: ObservableObject {
  @Published var hero: Hero
  @Published var show = false
  @Published var color: Color = .blue
  private let urlSeparator = "."
  
  init(hero: Hero) {
    self.hero = hero
  }

  var heroID: Int {
    return hero.heroID
  }

  var name: String {
    return hero.name
  }

  var description: String {
    return hero.description
  }

  var thumbnailImage: String {
    return hero.thumbnail.path + urlSeparator + hero.thumbnail.imageExtension
  }
}
