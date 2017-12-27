//
//  ViewController.swift
//  Checklist
//
//  Created by Andrew Velikiy on 12/27/17.
//  Copyright © 2017 Andrey Velikiy. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var items: [ChecklistItem]
    
    @IBAction func addItem() {
        print("Added item")
        let newRowIndex = items.count
        let newItem = ChecklistItem()
        let randomNumber = Int(arc4random_uniform(UInt32(items.count)))
        newItem.text = items[randomNumber].text
        newItem.checked = true
        items.append(newItem)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        let row0Item = ChecklistItem()
        row0Item.checked = false
        row0Item.text = "Walk the dog"
        items.append(row0Item)
        
        let row1Item = ChecklistItem()
        row1Item.checked = false
        row1Item.text = "Brush the teeth"
        items.append(row1Item)
        
        let row2Item = ChecklistItem()
        row2Item.checked = false
        row2Item.text = "Learn iOS development"
        items.append(row2Item)
        
        let row3Item = ChecklistItem()
        row3Item.checked = false
        row3Item.text = "Soccer practice"
        items.append(row3Item)
        
        let row4Item = ChecklistItem()
        row4Item.checked = false
        row4Item.text = "Eat ice cream"
        items.append(row4Item)
        
        let row5Item = ChecklistItem()
        row5Item.checked = false
        row5Item.text = "Find work"
        items.append(row5Item)
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Deleted row")
        items.remove(at: indexPath.row)
        print(items.count)
        
        //delete
        //with animation
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        print("Updated view")
        //without animation
//        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
//            item.checked = !item.checked //this is what ChecklistItem itself must do (below)
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: items[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel //not safe; without AS returns a view, not a label
        label.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
}

