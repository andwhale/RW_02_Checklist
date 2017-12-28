//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Andrew Velikiy on 12/27/17.
//  Copyright © 2017 Andrey Velikiy. All rights reserved.
//

import Foundation

//need to subclass from NSObject for it to be Equatable
class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
