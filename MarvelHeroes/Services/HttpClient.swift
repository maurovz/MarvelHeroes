import Foundation

protocol URLSessionProtocol {
  typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
  func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
  func resume()
}

class HttpClient {
  typealias CompleteClosure = ( _ data: Data?, _ error: Error?) -> Void
  private let session: URLSessionProtocol

  init(session: URLSessionProtocol) {
    self.session = session
  }

  func get( url: URL, callback: @escaping CompleteClosure ) {
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.get.rawValue
    let task = session.dataTask(with: request) { (data, _, error) in
      callback(data, error)
    }
    task.resume()
  }
}

enum HttpMethod: String {
  case get = "GET"
}

extension URLSession: URLSessionProtocol {
  func dataTask(with request: URLRequest,
                completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
    return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
  }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
