//
//  SubWaysCoordinator.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/09/21.
//

import UIKit
class SubWaysCoordinator : Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigatorController: UINavigationController
    
    init(navigatorController : UINavigationController) {
        self.navigatorController = navigatorController
    }
    
    func start() {
        let vc = MainCoorditorVC.instantiate()
        vc.coordinator = self
        navigatorController.pushViewController(vc, animated: false)
    }
    func buyAction() {
        let vc = BuyViewController.instantiate()
        vc.coodinator = self
        navigatorController.pushViewController(vc, animated: false)
    }
    
   
    
}
