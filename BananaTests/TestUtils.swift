

//
//  TestUtils.swift
//  Banana
//
//  Created by Bhargav Gurlanka on 4/13/16.
//  Copyright © 2016 Bhargav Gurlanka. All rights reserved.
//

import Foundation


class Utils {
    static func loadJSON(fileName: String) -> AnyObject {
        
        let path = NSBundle(forClass: Utils.self).pathForResource(fileName, ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
        return json!
    }
}