//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Andrew Velikiy on 12/27/17.
//  Copyright © 2017 Andrey Velikiy. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        if (textField.text?.isEmpty)! {
            saveBarButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self //or via storyboard: r-click on textfield and select delegate -> ViewController
    }
    
    //what to do when RETURN is hit
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        print("Resigned FirstResponder")
//        return false
//    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
        print("Canceled new item")
    }
    
    @IBAction func save() {
        navigationController?.popViewController(animated: true)
        print("Saved new item: \(textField.text!)")
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty {
            saveBarButton.isEnabled = false
        } else {
            saveBarButton.isEnabled = true
        }
        return true
    }
}
