import UIKit

protocol CountriesNavigable: Navigable {
  func toMeasurement(countryCode: CountryCode)
}

final class CountriesNavigator: CountriesNavigable {
  var service: Service
  var navigationManager: NavigationManager
  
  init(service: Service, navigationManager: NavigationManager) {
    self.service = service
    self.navigationManager = navigationManager
    
    setupNavBarAppareance()
  }
  
  private func setupNavBarAppareance() {
    navigationManager.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationManager.navigationController.navigationBar.shadowImage = UIImage()
    navigationManager.navigationController.navigationBar.isTranslucent = true
    navigationManager.navigationController.view.backgroundColor = .systemGray6
  }
  
  func toMeasurement(countryCode: CountryCode) {
    let facade = MeasurementsFacadeImpl(service: service.measurementsService)
    let measurementNavigator = MeasurementNavigator(service: service, navigationManager: navigationManager)
    let measurementViewController = MeasurementsViewController(facade: facade, navigator: measurementNavigator, countryCode: countryCode)
    
    navigationManager.push(measurementViewController, animated: true)
  }
}
