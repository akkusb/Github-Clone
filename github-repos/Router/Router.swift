//
//  Router.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class Router {
    static func pushRepositoryDetail(repository: RepositoryModel, animated: Bool = true) {
        let vc = RepositoryDetailViewController()
        vc.repository = repository
        getCurrentNavigationController()?.pushViewController(vc, animated: animated)
    }
    
    static func pushUserDetail(user: UserModel, animated: Bool = true) {
        let vc = UserDetailViewController()
        vc.user = user
        getCurrentNavigationController()?.pushViewController(vc, animated: animated)
    }
    
    static func getCurrentNavigationController() -> UINavigationController? {
        if let currentScene = UIApplication.shared.connectedScenes.first {
            if let sceneDelegate = currentScene.delegate as? SceneDelegate {
                if let navigationController = sceneDelegate.window?.rootViewController as? UINavigationController {
                    return navigationController
                }
            }
        }
        return nil
    }
}
