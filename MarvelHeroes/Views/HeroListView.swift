import SwiftUI

struct HeroListView: View {
  @ObservedObject private var heroListViewModel = HeroListViewModel()
  
  var body: some View {
    NavigationView {
      List(self.heroListViewModel.heroes, id: \.id) { hero in
        VStack {
          NavigationLink(destination: HeroDetailView(hero: hero)) {
              Text(hero.name)
          }.navigationBarTitle("Hero Stats")
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
