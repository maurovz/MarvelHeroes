import Foundation
import SwiftUI

class HeroDetailsViewModel: ObservableObject {
  @Published var hero: HeroDetails
  @Published var show = false
  @Published var color: Color = Color(Constants.heroBackground)

  init(hero: HeroDetails) {
    self.hero = hero
  }

  var name: String {
    return hero.name ?? ""
  }

  var description: String {
    return hero.heroDescription ?? ""
  }

  var thumbnailImage: String {
    return hero.thumbnailURL ?? ""
  }

  var comics: String {
    return String(hero.comics)
  }

  var events: String {
    return String(hero.events)
  }

  var stories: String {
    return String(hero.stories)
  }

  var series: String {
    return String(hero.series)
  }
}
