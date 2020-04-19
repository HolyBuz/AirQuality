import Foundation
@testable import AirQuality

class MockCountriesFacade: CountriesFacade {
  
  var shouldReturnData = false
  
  func getCountries(completion: @escaping (Result<[CountryViewModel], Error>) -> ()) {
    if shouldReturnData {
      completion(.success([CountryViewModel(country: Country.testData())]))
    } else {
      completion(.failure(NSError(domain: "Error", code: 400, userInfo: ["reason": "shouldReturnError == true"])))
    }
  }
}
