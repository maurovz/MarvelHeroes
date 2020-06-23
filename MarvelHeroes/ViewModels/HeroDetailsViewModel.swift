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
}
