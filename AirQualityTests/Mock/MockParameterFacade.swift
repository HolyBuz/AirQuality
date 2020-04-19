import Foundation
@testable import AirQuality
class MockParametersFacade: ParametersFacade {
  
  var shouldReturnData = false
  
  func getParameterDetail(for parameter: String, completion: @escaping (Result<ParameterViewModel?, Error>) -> ()) {
    if shouldReturnData {
      completion(.success(ParameterViewModel(parameter: Parameter.testData())))
    } else {
      completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "shouldReturnError == true"])))
    }
  }
}
