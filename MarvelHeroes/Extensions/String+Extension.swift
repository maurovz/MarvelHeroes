import Foundation

extension String {
  var dateFromString: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from: self)
  }
}
