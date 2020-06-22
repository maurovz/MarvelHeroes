import SwiftUI
import KingfisherSwiftUI

struct HeroDetailView: View {
  var hero: HeroViewModel
  @Binding var show: Bool
  @Binding var active: Bool
  @Binding var activeIndex: Int
  @Binding var isScrollable: Bool
  var bounds: GeometryProxy
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
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
              .onTapGesture {
                self.show = false
                self.active = false
                self.activeIndex = -1
                self.isScrollable = false
              }
            }
          }
          Spacer()
          KFImage(URL(string: hero.thumbnailImage))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(25)
            .frame(maxWidth: .infinity)
            .frame(height: 300, alignment: .top)
        }
        .padding(show ? 30 : 20)
        .padding(.top, show ? 30 : 0)
        .frame(maxWidth: show ? .infinity : bounds.size.width - 60)
        .frame(height: show ? 460 : 280)
        .background(hero.color)
        .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
        .shadow(color: Color(.blue).opacity(0.3), radius: 20, x: 0, y: 20)
        
        VStack(alignment: .leading, spacing: 30.0) {
          Text(hero.name)
          Text("Hero Description")
            .font(.title).bold()
          Text(hero.description)
        }
        .padding(30)
      }
    }
    .edgesIgnoringSafeArea(.all)
  }
}

//struct CourseDetail_Previews: PreviewProvider {
//  static var previews: some View {
//    GeometryReader { bounds in
//      CourseDetail(course: Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false), show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true), bounds: bounds)
//    }
//  }
//}
