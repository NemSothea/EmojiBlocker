//
//  Storyboarded.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/09/21.
//

import UIKit

protocol Storyboarded {
    
    static func instantiate() -> Self
    
}
extension Storyboarded where Self : UIViewController {
    
    static func instantiate() -> Self {
        //This is pull out "Main Coordinator class"
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everthing after, giving "Coordintor ViewController"
        let className = fullName.components(separatedBy: ".")[1]
        let storyBoard = UIStoryboard(name: "MainCoorditorSB", bundle: Bundle.main)
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyBoard.instantiateViewController(withIdentifier: className) as! Self
        
    }
    
}
