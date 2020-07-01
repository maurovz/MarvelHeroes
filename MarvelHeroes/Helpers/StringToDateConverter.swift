import Foundation

struct StringDateFormater {
  static func convertStringToDate(string: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from: string)
  }

  static func convertDateToString(date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let string = formatter.string(from: date)
    guard let date = formatter.date(from: string) else { return nil}
    formatter.dateFormat = "dd-MMM-yyyy"
    return formatter.string(from: date)
  }
}
