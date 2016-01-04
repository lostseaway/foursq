//
//  RightMenuViewController.swift
//  4sqmap
//
//  Created by LostSeaWay on 12/30/2558 BE.
//  Copyright © 2558 LostSeaWay. All rights reserved.
//

import UIKit

class RightMenuViewController: UIViewController {

    var place : FQPlace?
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_address: UITextView!
    @IBOutlet weak var label_type: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if place != nil{
            print("Select Name : \((place?.name)! as String)")
            label_name.text = place?.name
            label_address.text = place?.address
            label_type.text = place?.catagory
        }

    }

}
