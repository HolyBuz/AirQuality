import Foundation

protocol MeasurementsFacade {
  func getAllMeasurements(for countryCode: CountryCode, completion :@escaping (Result<[MeasurementViewModel], Error>) -> ())
  func getMeasurements(for parameter: String, with countryCode: CountryCode, completion :@escaping (Result<[MeasurementViewModel], Error>) -> ())
}

class MeasurementsFacadeImpl: MeasurementsFacade {
  let service: MeasurementsService
  var activeFilter: String?
  
  init(service: MeasurementsService) {
    self.service = service
  }
  
  
  
  func getAllMeasurements(for countryCode: CountryCode, completion :@escaping (Result<[MeasurementViewModel], Error>) -> ()) {
    service.getAllMeasurements(for: countryCode, completion: { result in
      switch result {
      case .success(let measurements):
        let measurementViewModels = measurements.results
          .filter({ $0.value != 0.0 && $0.city != "N/A"})
          .sorted(by: { $0.parameter > $1.parameter})
          .map { MeasurementViewModel(measurement: $0)}
        
        DispatchQueue.main.async {
          completion(.success(measurementViewModels))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
  
  func getMeasurements(for parameter: String, with countryCode: CountryCode, completion :@escaping (Result<[MeasurementViewModel], Error>) -> ()) {
    
    if activeFilter != parameter {
      activeFilter = parameter
    } else {
      activeFilter = nil
    }
    
    service.getMeasurements(for: activeFilter, with: countryCode, completion: { result in
      
      switch result {
      case .success(let measurements):
        let measurementViewModels = measurements.results
          .filter({ $0.value != 0.0})
          .sorted(by: { $0.parameter > $1.parameter})
          .map { MeasurementViewModel(measurement: $0)}
        
        DispatchQueue.main.async {
          completion(.success(measurementViewModels))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
}
