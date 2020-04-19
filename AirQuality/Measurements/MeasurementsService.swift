protocol MeasurementsService {
  func getAllMeasurements(for countryCode: CountryCode, completion :@escaping (Result<RootMeasurement, Error>) -> ())
  func getMeasurements(for parameter: String?, with countryCode: CountryCode, completion :@escaping (Result<RootMeasurement, Error>) -> ())
}

final class MeasurementsServiceImpl: MeasurementsService {
  let backend: Backend
  
  
  init(backend: Backend) {
    self.backend = backend
  }
  
  func getAllMeasurements(for countryCode: CountryCode, completion :@escaping (Result<RootMeasurement, Error>) -> ()) {
    let filters = ["country": countryCode]
    let resource = Resource(path: "measurements", parameters: filters)

    print(resource.url)
    
    backend.request(resource, type: RootMeasurement.self, completion: { response in
      completion(response)
    })
  }
  
  func getMeasurements(for parameter: String?, with countryCode: CountryCode, completion :@escaping (Result<RootMeasurement, Error>) -> ()) {
    var filters = ["country": countryCode]
    
    if let parameter = parameter {
      filters["parameter"] = parameter
    }
    
    let resource = Resource(path: "measurements", parameters: filters)
    print(resource.url)
    
    backend.request(resource, type: RootMeasurement.self, completion: { response in
      completion(response)
    })
  }
}
