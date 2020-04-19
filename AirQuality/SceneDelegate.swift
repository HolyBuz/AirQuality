//
//  SceneDelegate.swift
//  AirQuality
//
//  Created by Alessandro Loi on 25/02/2020.
//  Copyright © 2020 Alessandro Loi. All rights reserved.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let rootViewController = setupRootViewController()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
    window?.windowScene = windowScene
  }
  
  fileprivate func setupRootViewController() -> UIViewController {
    let backend = Backend()
    let service = CoreService(backend: backend)
    let facade = CountriesFacadeImpl(service: service.countriesService)
    let navigationManager = NavigationManager()
    let countriesNavigator = CountriesNavigator(service: service, navigationManager: navigationManager)
    let viewController = CountriesViewController(facade: facade, navigator: countriesNavigator)
    navigationManager.setRootViewController(viewController)
    
    return navigationManager.navigationController
  }
}

