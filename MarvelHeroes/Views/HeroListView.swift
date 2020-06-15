import SwiftUI

struct HeroListView: View {
  @ObservedObject private var heroListViewModel = HeroListViewModel()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(self.heroListViewModel.heroes, id: \.id) { hero in
          VStack {
            Text("Hero's Name")
          }
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
