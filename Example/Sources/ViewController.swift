//
//  ViewController.swift
//  Example
//
//  Created by Bhargav Gurlanka on 4/11/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import UIKit
import Banana

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = NSBundle.mainBundle().pathForResource("customers", ofType: "json"),
            let data = NSData(contentsOfFile: path),
            let jsonData = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
                print("Couldn't load JSON file")
                exit(1)
        }
        
        do {
            let customers: [Customer]? =  try get(jsonData) <~~ keyPath("response.customers") <<~ Customer.init
            print(customers)
        } catch {
            // Failed to parse JSON
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

