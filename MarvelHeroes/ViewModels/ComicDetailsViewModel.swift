import Foundation

class ComicDetailsViewModel: ObservableObject {
  @Published var comic: ComicDetails

  init(comic: ComicDetails) {
    self.comic = comic
  }

  var title: String {
    return comic.title ?? ""
  }

  var description: String {
    return comic.comicDescription ?? ""
  }

  var thumbnailImage: String {
    return comic.thumbnailURL ?? ""
  }
}
