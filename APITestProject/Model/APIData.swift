//
//  APIData.swift
//  APITestProject
//
//  Created by Macbook Pro on 24/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class APIData: NSObject {
    
    var strGetTitle:String!
    var strGetCreatedAt:String
    var isSelectedCell:Bool = false
    var finalPage :Int!
    var currentPage:Int!
    init(dictionary: [String: Any]) {
        
        strGetTitle = dictionary["title"] as? String ?? ""
        strGetCreatedAt = dictionary["created_at"] as? String ?? ""
        currentPage = dictionary["page"] as? Int
        currentPage = dictionary["nbPages"] as? Int
    }
}
