//
//  AddItemViewController.swift
//  ToDo
//
//  Created by Thomas Röthemeyer on 31/12/2015.
//  Copyright © 2015 Thomas Röthemeyer. All rights reserved.
//

import UIKit

protocol AddItemViewControllerProtocol {
    func addItem(item: String)
}

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField?

    var delegate: AddItemViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = "Add Item"
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "didTapCancel:")
        
        self.textField?.becomeFirstResponder()
        self.textField?.delegate = self
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            if let delegate = self.delegate, let item = textField.text where textField.text?.characters.count > 0 {
                delegate.addItem(item)
            }
        }
    
        return true
    }
    
    // MARK: Actions
    
    func didTapCancel(sender: UIBarButtonItem){
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
