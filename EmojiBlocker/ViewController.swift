//
//  ViewController.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/08/29.
//

import UIKit

class ViewController: UIViewController {

    /* TODO :
     - Outlet
    */
    
    @IBOutlet weak var MyTextView   : UITextView!
    @IBOutlet weak var MyLabelError : UILabel!
    @IBOutlet weak var MyDoneButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.MyLabelError.isHidden  = true
        
        self.MyDoneButton.layer.cornerRadius = 12
        self.MyDoneButton.layer.borderWidth = 1
        self.MyDoneButton.layer.borderColor = UIColor.gray.cgColor
        
//        self.MyTextView.keyboardType = .asciiCapable = Displays a keyboard which can enter ASCII characters
        self.MyTextView.layer.cornerRadius = 5
        self.MyTextView.delegate    = self
        
        
    }
    /* TODO :
     - Action
    */
    
    @IBAction func doneAction(_ sender: Any) {
        
        self.MyTextView.resignFirstResponder()
        
    }
    

}
extension ViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if containValidCharacters(text) {
            self.MyLabelError.isHidden = true
            return true
        }
        self.MyLabelError.isHidden = false
        return false
    }
    private func containValidCharacters(_ text : String) -> Bool {
        let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/# \n"
        let inValidSet = CharacterSet(charactersIn: validChars).inverted
        return text.rangeOfCharacter(from: inValidSet) == nil
    }
    
}
