import Foundation

struct Thumbnail: Decodable {
  let path: String
  let imageExtension: String

  enum CodingKeys: String, CodingKey {
    case path
    case imageExtension = "extension"
  }
}
