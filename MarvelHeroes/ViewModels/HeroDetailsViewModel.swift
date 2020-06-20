import Foundation

struct HeroDetailsViewModel {
  let hero: HeroDetails

  var name: String {
    return hero.name ?? ""
  }

  var description: String {
    return hero.heroDescription ?? ""
  }
}
