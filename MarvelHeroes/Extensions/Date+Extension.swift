import Foundation

extension Date {
  var formattedDateString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    let string = formatter.string(from: self)
    return string
  }
}
