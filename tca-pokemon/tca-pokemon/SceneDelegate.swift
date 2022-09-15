//
//  SceneDelegate.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/30.
//

import UIKit

import ComposableArchitecture

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = ViewController(store: Store(
            initialState: AppState(pokemonInfos: [], items: [], types: []),
            reducer: appReducer,
            environment: AppEnvironment(client: NetworkClient.live))
        )
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigation
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
