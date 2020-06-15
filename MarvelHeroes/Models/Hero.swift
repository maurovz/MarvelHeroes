import Foundation

struct Hero: Codable {
  let id: Int
  let name: String
  let description: String
  let thumbnail: Thumbnail
}

struct Thumbnail {
  let path: String
  let imageExtension: String
  
  enum CodingKeys: String, CodingKey {
    case path
    case imageExtension = "extension"
  }
}
