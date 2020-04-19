@testable import AirQuality
import Foundation

class MockMeasurementService: MeasurementsService {
  
  var shouldReturnData = false
  func getAllMeasurements(for countryCode: CountryCode, completion: @escaping (Result<RootMeasurement, Error>) -> ()) {
    if shouldReturnData {
      completion(.success(RootMeasurement(results: [Measurement.testData(country: countryCode)])))
    } else {
      completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "shouldReturnData == false"])))
    }
  }
  
  func getMeasurements(for parameter: String?, with countryCode: CountryCode, completion: @escaping (Result<RootMeasurement, Error>) -> ()) {
    if shouldReturnData {
      completion(.success(RootMeasurement(results: [Measurement.testData(parameter: parameter ?? "", country: countryCode)])))
    } else {
      completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "shouldReturnData == false"])))
    }
  }
}
