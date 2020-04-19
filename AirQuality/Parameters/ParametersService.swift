import Foundation

protocol ParametersService {
  func getParameters(completion :@escaping (Result<RootParameter, Error>) -> ())
}

final class ParametersServiceImpl: ParametersService {
  let backend: Backend
  
  init(backend: Backend) {
    self.backend = backend
  }
  
  func getParameters(completion :@escaping (Result<RootParameter, Error>) -> ()) {
    backend.request(Resource(path: "parameters"), type: RootParameter.self, completion: { response in
      completion(response)
    })
  }
}
