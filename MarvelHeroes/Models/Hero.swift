import Foundation

struct Hero: Decodable {
  let heroID: Int
  let name: String
  let description: String
  let thumbnail: Thumbnail
  let series: Available
  let comics: Available
  let stories: Available
  let events: Available

  enum CodingKeys: String, CodingKey {
    case heroID = "id"
    case name
    case description
    case thumbnail
    case series
    case comics
    case stories
    case events
  }
}

struct Available: Decodable {
  let available: Int
}
