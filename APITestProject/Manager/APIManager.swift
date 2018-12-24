//
//  APIManager.swift
//  APITestProject
//
//  Created by Macbook Pro on 24/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation
import Alamofire


class APIManager {
    
    static let shared: APIManager = {
        
        let instance = APIManager()
        return instance
        
    }()
    
    func callTestAPIsearchByDateWith(tag: String, page: Int, complition:@escaping([APIData]?, Bool?, String?)->()){
        
        let url = URLS.searchByTagAPI + "tags=\(tag)&page=\(page)"
        
        Alamofire.request(url, method: .get, parameters: nil, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                print(response.result.value as? [String:Any] ?? "No result")
                var arrayHitsObject:[APIData] = []
                if let result = response.result.value as? [String:Any] {
                    
                    if let arrayHits = result["hits"] as? [[String:Any]] {
                        
                        for object in arrayHits {
                            
                            let objHit = APIData(dictionary: object)
                            arrayHitsObject.append(objHit)
                        }
                        
                    }
                }
                
                complition(arrayHitsObject, true, nil)
                
            case .failure(let error) :
                print(error)
                complition([],false, error.localizedDescription)
                
            }
        }
        
    }
    
}
