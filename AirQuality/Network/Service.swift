import Foundation

protocol Service {
  var measurementsService: MeasurementsService { get }
  var countriesService: CountriesService { get }
  var parameterService: ParametersService { get }
}

final class CoreService: Service {
  var measurementsService: MeasurementsService
  var countriesService: CountriesService
  var parameterService: ParametersService
  
  init(backend: Backend) {
    self.countriesService = CountriesServiceImpl(backend: backend)
    self.measurementsService = MeasurementsServiceImpl(backend: backend)
    self.parameterService = ParametersServiceImpl(backend: backend)
  }
}
