import SwiftUI

struct HeroDetailView: View {
  let hero: HeroViewModel

  var body: some View {
    VStack {
      Text(hero.name)
    }
  }
}

struct HeroDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let thumbnail = Thumbnail(path: "", imageExtension: "")
    let hero = Hero(heroID: 1, name: "Jessica Jones", description: "Netflix", thumbnail: thumbnail)
    return HeroDetailView(hero: HeroViewModel(hero: hero))
  }
}
