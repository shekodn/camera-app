//
//  Report.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/8/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import Foundation


class Report {
    
    
    //Private
    var id : Int
//        {
//        get {
//            return self.id
//        }
//        
//        set{
//            
//            self.id = newValue
//        }
//        
//    }
    
    var name : String
//        {
//        
//        get {
//            return self.name
//        }
//        
//        set{
//            
//            self.name = newValue
//        }
//        
//    }
    
    var description : String
//        {
//        
//        get {
//            return self.description
//        }
//        
//        set{
//            
//            self.description = newValue
//        }
//    }
    
    
    
    //Public
    public init() {
        
        id = 0
        name = "Report"
        description = "No description"
    }
    
    public init(id:Int, name:String, description:String) {
        
        self.id = id
        self.name = name
        self.description = description
    }
}



