import Foundation

struct APIResponse: Decodable {
  let code: Int
  let status: String
  let data: HeroData
}

struct HeroData: Decodable {
  let results: [Hero]
}
