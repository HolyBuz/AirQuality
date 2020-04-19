import Foundation

protocol ParametersFacade {
  func getParameterDetail(for parameter: String, completion :@escaping (Result<ParameterViewModel?, Error>) -> ())
}

class ParametersFacadeImpl: ParametersFacade {
  let service: ParametersService
  
  init(service: ParametersService) {
    self.service = service
  }
  
  func getParameterDetail(for parameter: String, completion :@escaping (Result<ParameterViewModel?, Error>) -> ()) {
    service.getParameters(completion: { result in
      switch result {
      case .success(let parameters):
        let parameterViewModel = parameters.results
                                           .first(where:{$0.name == parameter})
                                           .map{ ParameterViewModel(parameter: $0)}
        
        DispatchQueue.main.async {
          completion(.success(parameterViewModel))
        }
      case .failure(let error):
        completion(.failure(error))
      }
      
    })
  }
}
