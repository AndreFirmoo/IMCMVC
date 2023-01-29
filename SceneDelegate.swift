//
//  SceneDelegate.swift
//  IMC
//
//  Created by Andre Firmo on 21/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene =  windowScene
        window?.rootViewController = builderNavigationController()
        window?.makeKeyAndVisible()
    }
    
    private func builderNavigationController() -> UINavigationController {
        let model = IMCModel()
        let viewController = IMCController(model: model)
        model.output = viewController
        return UINavigationController(rootViewController: viewController)
    }
}

