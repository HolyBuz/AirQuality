import Foundation
@testable import AirQuality
class MockMeasurementsFacade: MeasurementsFacade {
  
  var shouldReturnEmpty = false
  var shouldReturnData = false
  
  func getAllMeasurements(for countryCode: CountryCode, completion: @escaping (Result<[MeasurementViewModel], Error>) -> ()) {
    if shouldReturnData {
      if !shouldReturnEmpty {
        completion(.success([MeasurementViewModel(measurement: Measurement.testData(country: countryCode))]))
      } else {
        completion(.success([MeasurementViewModel]()))
      }
    } else {
      completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "shouldReturnError == true"])))
    }
  }
  
  func getMeasurements(for parameter: String, with countryCode: CountryCode, completion: @escaping (Result<[MeasurementViewModel], Error>) -> ()) {
    if shouldReturnData {
      if !shouldReturnEmpty {
        completion(.success([MeasurementViewModel(measurement: Measurement.testData(parameter: parameter, country: countryCode))]))
      } else {
        completion(.success([MeasurementViewModel]()))
      }
    } else {
      completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "shouldReturnError == true"])))
    }
  }
}
