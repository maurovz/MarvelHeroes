import Foundation

struct HeroViewModel {
  let hero: Hero
  
  var id: Int {
    return hero.id
  }
  
  var name: String {
    return hero.name
  }
  
  var description: String {
    return hero.description
  }
  
  var thumbnailImage: String {
    return hero.thumbnail.path + hero.thumbnail.imageExtension
  }
}
