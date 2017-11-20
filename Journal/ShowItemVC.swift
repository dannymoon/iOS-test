//
//  ShowItemVC.swift
//  Journal
//
//  Created by Danny Moon on 11/17/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit

class ShowItemVC: UIViewController {

    
    var name = ""
    var number = ""
    
    @IBOutlet weak var nameTextShow: UILabel!
    @IBOutlet weak var numberTextShow: UILabel!
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextShow.text = name
        numberTextShow.text = number
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
