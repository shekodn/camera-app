//
//  Report.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/8/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import Foundation
import UIKit


class Report {
    
    var id : Int!
    var name : String!
    var desc : String!
    var image : UIImage!
    
    
    
    //Public
    public init() {
        
        id = 0
        name = "Report"
        desc = "No description"
    }
    
    public init(id:Int, name:String, description:String) {
        
        self.id = id
        self.name = name
        self.desc = description
    }
}



