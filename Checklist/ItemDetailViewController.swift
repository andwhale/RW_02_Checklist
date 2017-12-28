//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Andrew Velikiy on 12/27/17.
//  Copyright © 2017 Andrey Velikiy. All rights reserved.
//

import UIKit

//protocol defines things that a class must implement; you can't create an instance of a protocol
// : class restricts to class objects
// we need to also add a property for a delegate that is the object that is going to carry these methods
protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewControllerDidAdd(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewControllerDidEdit(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    var itemToEdit: ChecklistItem?
    
    //a delegate property
    weak var delegate: ItemDetailViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        if (textField.text?.isEmpty)! {
            saveBarButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self //or via storyboard: r-click on textfield and select delegate -> ViewController
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
        }
    }
    
    //what to do when RETURN is hit
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        print("Resigned FirstResponder")
//        return false
//    }
    
    @IBAction func cancel() {
        //navigationController?.popViewController(animated: true)
        print("Canceled new item")
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func save() {
        if itemToEdit == nil {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            print("Saved new item: \(textField.text!)")
            delegate?.itemDetailViewControllerDidAdd(self, didFinishAdding: item)
        } else {
            print("Edited item: \(itemToEdit!.text) -> \(textField.text!)")
            itemToEdit?.text = textField.text!
            delegate?.itemDetailViewControllerDidEdit(self, didFinishEditing: itemToEdit!)
        }
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
