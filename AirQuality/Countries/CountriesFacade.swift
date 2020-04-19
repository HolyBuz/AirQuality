import Foundation

protocol CountriesFacade {
  func getCountries(completion :@escaping (Result<[CountryViewModel], Error>) -> ())
}

class CountriesFacadeImpl: CountriesFacade {
  let service: CountriesService
  
  init(service: CountriesService) {
    self.service = service
  }
  
  func getCountries(completion :@escaping (Result<[CountryViewModel], Error>) -> ()) {
    service.getCountries(completion: { result in
      
      switch result {
      case .success(let countries):
        let cityViewModels = countries.results.filter{ $0.name != nil && $0.count != 0 }.map { CountryViewModel(country: $0)}
        DispatchQueue.main.async {
          completion(.success(cityViewModels))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    })
  }
}
