import SwiftUI

struct HeroListView: View {
    var body: some View {
      NavigationView {
        List {
          Text("Hero's Name")
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HeroListView()
    }
}
