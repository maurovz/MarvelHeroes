import SwiftUI

struct HeroListView: View {
  @ObservedObject private var heroListViewModel = HeroListViewModel()

  var body: some View {
    NavigationView {
      List(self.heroListViewModel.heroes, id: \.heroID) { hero in
        VStack {
          NavigationLink(destination: HeroDetailView(hero: hero)) {
              Text(hero.name)
          }.navigationBarTitle(NSLocalizedString("Hero Information", comment: "List title"))
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HeroListView()
  }
}
