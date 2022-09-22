//
//  Coordinator.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/09/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators : [Coordinator] { get set}
    
    var navigatorController : UINavigationController { get set}
    
    func start()
}
