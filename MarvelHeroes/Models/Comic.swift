import Foundation

struct Comic: Decodable {
  let comicID: Int
  let title: String
  let description: String?
  let thumbnail: Thumbnail

  enum CodingKeys: String, CodingKey {
    case comicID = "id"
    case title
    case description
    case thumbnail
  }
}
