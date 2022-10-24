// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let applicationScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = applicationScene
        window?.makeKeyAndVisible()

        let startViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: startViewController)
        window?.rootViewController = navigationController
    }
}
