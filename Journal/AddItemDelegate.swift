//
//  AddItemDelegate.swift
//  Journal
//
//  Created by Danny Moon on 11/17/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit

protocol AddItemDelegate: class {
    func addItem(_ firstname: String, _ lastname: String, _ number: String, sender: UIViewController, indexPath:IndexPath?)
}
