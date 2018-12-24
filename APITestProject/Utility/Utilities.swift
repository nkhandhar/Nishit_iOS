//
//  Utilities.swift
//  APITestProject
//
//  Created by Macbook Pro on 24/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

struct URLS {
    
    static let BASE_URL = "https://hn.algolia.com/api/v1/",
    searchByTagAPI = BASE_URL + "search_by_date?"
    
}


class Utilities: NSObject {
    class func setAlertWith(title:String?, message:String?, controller: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            // Nothing
        }))
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
