import Foundation

struct Constants {
  static let apiURL = "https://gateway.marvel.com:443/v1/public/"
  static let heroesEndpoint = "characters?apikey=\(apiKey)\(hash)\(timeStamp)\(orderByLatestParameter)&limit=50"
  static let comicsEndpoint = "comics?apikey=\(apiKey)\(hash)\(timeStamp)\(orderByLatestParameter)&limit=50"
  static let apiKey = "0c5a611113f2aa779e8988bb6a0e8447"
  static let timeStamp = "&ts=ts2020"
  static let hash = "&hash=cb0c0b92b46b5a48de738ca8d92470e6"
  static let urlError = "Url is not correct"
  static let heroBackground = "heroBackground1"
  static let orderByLatestParameter = "&orderBy=-modified"
}
