protocol CountriesService {
  func getCountries(completion: @escaping(Result<RootCountry, Error>) -> Void)
}

final class CountriesServiceImpl: CountriesService {
  let backend: Backend
  
  init(backend: Backend) {
    self.backend = backend
  }
  
  func getCountries(completion: @escaping(Result<RootCountry, Error>) -> Void) {
    let resource = Resource(path: "countries")
    backend.request(resource, type: RootCountry.self, completion: { response in
      completion(response)
    })
  }
}
