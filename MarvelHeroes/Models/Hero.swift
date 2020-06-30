import Foundation

struct Hero: Decodable {
  let heroID: Int
  let name: String
  let description: String
  let thumbnail: Thumbnail

  enum CodingKeys: String, CodingKey {
    case heroID = "id"
    case name
    case description
    case thumbnail
  }
}
