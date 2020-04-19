import Foundation

class Resource {

  private var urlComponent: URLComponents {
    var urlComponent = URLComponents()
    urlComponent.scheme = scheme
    urlComponent.host = host
    urlComponent.path = path
    urlComponent.queryItems = queryItems
    return urlComponent
  }
  
  var queryItems: [URLQueryItem]? {
    guard let parameters = parameters else { return nil }

    return parameters.map { key, value in
      return URLQueryItem(name: key, value: value as? String)
    }
  }
  
  var url: URL {
    return urlComponent.url!
  }

  private var host = "api.openaq.org"
  private var scheme = "https"
  private let path: String
  private let parameters: [String: Any]?
  
  init(path: String, parameters: [String: Any]? = nil) {
    self.path =  "/v1/" + path
    self.parameters = parameters
  }
}
