import UIKit

final class NavigationManager: NSObject {
  var navigationController = UINavigationController()
  
  func push(_ viewController: UIViewController, animated: Bool) {
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  func presentAsPopover(_ viewController: UIViewController, from view: UIView, animated: Bool = true) {
    viewController.modalPresentationStyle = .popover
    viewController.preferredContentSize = CGSize(width: ViewConstants.detailPopupSize.width, height: ViewConstants.detailPopupSize.height)
    
    let popUpViewController = viewController.popoverPresentationController
    popUpViewController?.sourceView = view
    popUpViewController?.sourceRect = view.bounds
    popUpViewController?.delegate = self
    
    navigationController.present(viewController, animated: true, completion: nil)
  }
  
  func setRootViewController(_ viewController: UIViewController) {
    navigationController.viewControllers = [viewController]
  }
}

extension NavigationManager: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
}
