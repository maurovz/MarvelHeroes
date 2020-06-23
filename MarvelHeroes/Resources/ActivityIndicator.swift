import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  typealias UIViewType = UIActivityIndicatorView
  let style: UIActivityIndicatorView.Style

  func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
    return UIActivityIndicatorView(style: style)
  }

  func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
    uiView.startAnimating()
  }
}

struct ActivityIndicatorView<Content>: View where Content: View {
  @Binding var isDisplayed: Bool
  var content: () -> Content

  var body : some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        if self.isDisplayed {
          self.content()
            .disabled(true)
            .blur(radius: 5)
          VStack {
            Text(LocalizedStringKey("Loading"))
            ActivityIndicator(style: .large)
          }
          .frame(width: geometry.size.width/1.5, height: 200.0)
          .foregroundColor(Color.primary)
          .cornerRadius(20)
        } else {
          self.content()
        }
      }
    }
  }
}
