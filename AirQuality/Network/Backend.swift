import Foundation

struct Backend {
  func request<T: Decodable>(_ endpoint: Resource, type: T.Type, completion: @escaping (_ response: Result<T, Error>) -> Void) {
    let urlRequest = URLRequest(url: endpoint.url)
    let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data else {return
        completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "No Data"])))
      }
      
      let response = Response(data: data)
      if let decoded = response.decode(type) {
        completion(.success(decoded))
      } else {
        completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "Decoding Error"])))
      }
    }
    urlSession.resume()
  }
}
