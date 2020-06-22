import SwiftUI
import Combine

struct HeroListView: View {
  @ObservedObject private var heroListViewModel = HeroListViewModel()
  @State var active = false
  @State var activeIndex = -1
  @State var activeView = CGSize.zero
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @State var isScrollable = false
  private let screenSize = UIScreen.main.bounds

  var body: some View {
    GeometryReader { bounds in
      ZStack {
        ScrollView {
          VStack(spacing: 30) {
            Text("Top Marvel Heroes")
              .font(.largeTitle).bold()
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 30)
              .padding(.top, 30)
              .blur(radius: self.active ? 20 : 0)
            ForEach(self.heroListViewModel.heroes.indices, id: \.self) { index in
              GeometryReader { geometry in
                HeroCellView(
                  show: self.$heroListViewModel.heroes[index].show,
                  active: self.$active,
                  index: index,
                  activeIndex: self.$activeIndex,
                  activeView: self.$activeView,
                  bounds: bounds,
                  isScrollable: self.$isScrollable,
                  hero: self.heroListViewModel.heroes[index]
                )
                  .offset(y: self.heroListViewModel.heroes[index].show ? -geometry.frame(in: .global).minY : 0)
                  .opacity(self.activeIndex != index && self.active ? 0 : 1)
                  .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                  .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
              }
              .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
              .frame(maxWidth: self.heroListViewModel.heroes[index].show ? 712 : getCardWidth(bounds: bounds))
              .zIndex(self.heroListViewModel.heroes[index].show ? 1 : 0)
            }
          }
          .frame(width: bounds.size.width)
          .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
//        .statusBar(hidden: self.active ? true : false)
        .animation(.linear)
        .disabled(self.active && !self.isScrollable ? true : false)
      }
    }
  }
}

func getCardWidth(bounds: GeometryProxy) -> CGFloat {
  if bounds.size.width > 712 {
    return 712
  }
  return bounds.size.width - 60
}

func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
  if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 {
    return 0
  }
  return 30
}

struct HeroListView_Previews: PreviewProvider {
  static var previews: some View {
    HeroListView()
  }
}
