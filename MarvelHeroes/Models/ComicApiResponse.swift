import Foundation

struct ComicAPIResponse: Decodable {
  let code: Int
  let status: String
  let data: ComicData
}

struct ComicData: Decodable {
  let results: [Comic]
}
