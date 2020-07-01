import Foundation

struct Constants {
  static let apiURL = "https://gateway.marvel.com:443/v1/public/"
  static let heroesEndpoint = "characters?apikey=\(apiKey)\(hash)\(timeStamp)\(orderByLatestParameter)&limit=100"
  static let comicsEndpoint = "comics?apikey=\(apiKey)\(hash)\(timeStamp)\(comicFormat)"
  static let apiKey = "0c5a611113f2aa779e8988bb6a0e8447"
  static let timeStamp = "&ts=ts2020"
  static let hash = "&hash=cb0c0b92b46b5a48de738ca8d92470e6"
  static let urlError = "Url is not correct"
  static let orderByLatestParameter = "&orderBy=-modified"
  static let comicFormat = "&format=comic&startYear=2018&offset=101&limit=5"
  static let logoImage = "logo"
  static let noImageAvailable = "image_not_available"
  static let modifiedLabel = "Modified: "
  static let unkownModificationDate = "Unknown"
  static let sceneDefaultConfiguration = "Default Configuration"
  static let dequeErrorMessage = "Error dequeuing Reusable Cell"
}
