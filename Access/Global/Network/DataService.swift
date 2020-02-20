//
//  DataService.swift
//  Movie
//
//  Created by Yen on 2020/2/20.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation
import Alamofire
import Network


struct DataService {

   
   
// MARK: - Singleton
 static let shared = DataService()
let monitor = NWPathMonitor()
// MARK: - URL
  
    
   // private var Discover : String?
    
    func Https_Discover(Page:Int,completion: @escaping ([M_Home]?, Error?) -> ()){
           //https://api.github.com/users?since=0&per_page=20
                let  Discover_url = G_Base_Url + "?since=\(Page)" + "&per_page=20"
     
             Alamofire.request(Discover_url,method:.get).responseData{ response in
               
                      if let error = response.error
                      {
                          completion(nil, error)
                          return
                      }
                      if let result = response.value
                      {
                           var H_Model:[M_Home]?
                      
                       do {
                          // var M_Home_Data = [M_Home]()
                          H_Model = try JSONDecoder().decode([M_Home].self, from: result)
                       //  let list = list2
                        
                           let encoder = JSONEncoder()
                           encoder.outputFormatting = .prettyPrinted
                           let encoded = try! encoder.encode(H_Model)
                           
                           print(String(data: encoded, encoding: .utf8)!)
                           
                          } catch {
                                  print(error)
                         }
             
                          completion(H_Model, nil)
                          return
                      }
                  
                  }
                  
                  
              }
       //
//    func Https_Detail(id:String,completion: @escaping (M_Detail?, Error?) -> ()){
//              //    https://api.github.com/users/bmizerany
//                   let  Detail_url = G_Base_Url + "/\(id)" 
//        
//                Alamofire.request(Detail_url,method:.get).responseData{ response in
//                  
//                         if let error = response.error
//                         {
//                             completion(nil, error)
//                             return
//                         }
//                         if let result = response.value
//                         {
//                              var H_Model:M_Detail?
//                         
//                          do {
//                            
//                              H_Model = try JSONDecoder().decode(M_Detail.self, from: result)
//                              
//                              let encoder = JSONEncoder()
//                              encoder.outputFormatting = .prettyPrinted
//                              let encoded = try! encoder.encode(H_Model)
//                              
//                              print(String(data: encoded, encoding: .utf8)!)
//                              
//                             } catch {
//                                     print(error)
//                            }
//                
//                             completion(H_Model, nil)
//                             return
//                         }
//                     
//                     }
//                     
//                     
//                 }

        
        
}
