import UIKit

protocol MeasurementsNavigable: Navigable {
  func toParameterDetails(from view: UIView, with parameterID: ParameterID)
}

final class MeasurementNavigator: MeasurementsNavigable {

  var service: Service
  var navigationManager: NavigationManager
  
  init(service: Service, navigationManager: NavigationManager) {
    self.service = service
    self.navigationManager = navigationManager
  }
  
  func toParameterDetails(from view: UIView, with parameterID: ParameterID) {
    let facade = ParametersFacadeImpl(service: service.parameterService)
    let parameterViewController = ParameterDetailsViewController(facade: facade, parameterID: parameterID)
    navigationManager.presentAsPopover(parameterViewController, from: view)
  }
}
