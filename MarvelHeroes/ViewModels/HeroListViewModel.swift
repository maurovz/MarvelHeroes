import Foundation

class HeroListViewModel: ObservableObject {
  @Published var heroes: [HeroViewModel] = [HeroViewModel]()
}
