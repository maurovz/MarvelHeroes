import SwiftUI

struct HeroCellView: View {
  @Binding var show: Bool
  @Binding var active: Bool
  var index: Int
  @Binding var activeIndex: Int
  @Binding var activeView: CGSize
  var bounds: GeometryProxy
  @Binding var isScrollable: Bool
  var hero: HeroViewModel
  private let screenSize = UIScreen.main.bounds
  
  var body: some View {
    ZStack(alignment: .top) {
      VStack(alignment: .leading, spacing: 30.0) {
        Text(hero.name)
        Text("Hero Description")
          .font(.title).bold()
        Text(hero.description)
      }
      .padding(30)
      .frame(maxWidth: show ? .infinity : self.screenSize.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
      .offset(y: show ? 460 : 0)
      .background(Color("background"))
      .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
      .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
      .opacity(show ? 1 : 0)
      
      VStack {
        HStack(alignment: .top) {
          VStack(alignment: .leading, spacing: 8.0) {
            Text(hero.name)
              .font(.system(size: 24, weight: .bold))
              .foregroundColor(.white)
          }
          Spacer()
          ZStack {
            VStack {
              Image(systemName: "xmark")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            }
            .frame(width: 36, height: 36)
            .background(Color.black)
            .clipShape(Circle())
            .opacity(show ? 1 : 0)
            .offset(x: 2, y: -2)
          }
        }
        Spacer()
        Image("Avatar")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(25)
          .frame(maxWidth: .infinity)
          .frame(height: (show ? 250 : 170), alignment: .top)
        
      }
      .padding(show ? 30 : 20)
      .padding(.top, show ? 30 : 0)
      .frame(maxWidth: show ? .infinity : self.screenSize.width - 60, maxHeight: show ? 460 : 280)
      .background(hero.color)
      .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
      .shadow(color: Color(.black).opacity(0.3), radius: 20, x: 0, y: 20)
      .gesture(
        show ?
          DragGesture().onChanged { value in
            guard value.translation.height < 300 else { return }
            guard value.translation.height > 0 else { return }
            
            self.activeView = value.translation
          }
          .onEnded { value in
            if self.activeView.height > 50 {
              self.show = false
              self.active = false
              self.activeIndex = -1
              self.isScrollable = false
            }
            self.activeView = .zero
          }
          : nil
      )
        .onTapGesture {
          self.show.toggle()
          self.active.toggle()
          if self.show {
            self.activeIndex = self.index
          } else {
            self.activeIndex = -1
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.isScrollable = true
          }
      }
      
      if isScrollable {
        HeroDetailView(hero: hero, show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
          .background(Color.white)
          .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
          .animation(nil)
          .transition(.identity)
      }
    }
    .frame(height: show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
    .scaleEffect(1 - self.activeView.height / 1000)
    .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
    .hueRotation(Angle(degrees: Double(self.activeView.height)))
    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    .gesture(
      show ?
        DragGesture().onChanged { value in
          guard value.translation.height < 300 else { return }
          guard value.translation.height > 50 else { return }
          
          self.activeView = value.translation
        }
        .onEnded { value in
          if self.activeView.height > 50 {
            self.show = false
            self.active = false
            self.activeIndex = -1
            self.isScrollable = false
          }
          self.activeView = .zero
        }
        : nil
    )
      .disabled(active && !isScrollable ? true : false)
      .edgesIgnoringSafeArea(.all)
  }
}
