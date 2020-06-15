import Foundation

struct Hero: Decodable {
  let id: Int
  let name: String
  let description: String
  let thumbnail: Thumbnail
}

struct Thumbnail: Decodable {
  let path: String
  let imageExtension: String
  
  enum CodingKeys: String, CodingKey {
    case path
    case imageExtension = "extension"
  }
}
