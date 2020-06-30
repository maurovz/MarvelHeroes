import Foundation

struct HeroAPIResponse: Decodable {
  let code: Int
  let status: String
  let data: HeroData
}

struct HeroData: Decodable {
  let results: [Hero]
}
