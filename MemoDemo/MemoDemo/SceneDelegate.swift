//
//  SceneDelegate.swift
//  MemoDemo
//
//  Created by delma on 2022/08/17.
//

import UIKit

import ComposableArchitecture

var memos: IdentifiedArrayOf<MemoState> =  [
    MemoState(id: UUID(), contents: "hi", isLiked: false),
    MemoState(id: UUID(), contents: "good", isLiked: true),
    MemoState(id: UUID(), contents: "thanks", isLiked: false)
]

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = MemoListViewController(
            store: Store(
                initialState:
                    MemoListState(memos: memos),
                reducer: memoListReducer,
                environment: MemoListEnvironment()
            )
        )
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigation
        
        self.window = window
        window.makeKeyAndVisible()
    }

}

