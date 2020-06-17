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

struct Thumbnail: Decodable {
  let path: String
  let imageExtension: String

  enum CodingKeys: String, CodingKey {
    case path
    case imageExtension = "extension"
  }
}
