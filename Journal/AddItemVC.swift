//
//  AddItemVC.swift
//  Journal
//
//  Created by Danny Moon on 11/17/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit

class AddItemVC: UIViewController {
    var firstname = ""
    var lastname = ""
    var number = ""
    
    var indexPath: IndexPath?
    
    weak var delegate: AddItemDelegate?
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let fName = firstnameTextField.text!
        let lName = lastnameTextField.text!
        let num = numberTextField.text!
        
        if fName != "" &&  lName != "" && num != "" {
            
            delegate?.addItem(fName, lName, num, sender: self, indexPath: indexPath)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameTextField.text = firstname
        lastnameTextField.text = lastname
        numberTextField.text = number
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


