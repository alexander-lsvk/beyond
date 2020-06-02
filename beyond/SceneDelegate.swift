//
//  SceneDelegate.swift
//  beyond
//
//  Created by Alexander on 02.06.2020.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let chatView = ChatView()
        let chatViewModel = ChatViewModel()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: chatView.environmentObject(chatViewModel))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

