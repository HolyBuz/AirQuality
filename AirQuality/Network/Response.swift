import Foundation

struct Response {
  private var data: Data
  
  init(data: Data) {
    self.data = data
  }
}

extension Response {
  public func decode<T: Decodable>(_ type: T.Type) -> T? {
    do {
      let response = try JSONDecoder().decode(T.self, from: data)
      return response
    } catch let error {
      print(error.localizedDescription)
      return nil
    }
  }
}
