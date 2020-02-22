//
//  Detail_View_Model.swift
//  Access
//
//  Created by Yen on 2020/2/20.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

var bio_str = "bio"
var login_str = "login"
var location_str = "location"
var blog_str = "blog"

protocol Detail_View_Model_Delegate: AnyObject {
   
    func  show_webview(path:String)
}

class Detail_View_Model: NSObject
{
      weak var delegate: Detail_View_Model_Delegate?
      let selectedBackgroundView = UIView()
      var title_items = [String]()
      var items = [String:String]()
      var poster_img = UIImageView()
      var name:String?
      private var dataService: DataService?
      var Model_Detail:M_Detail?{
         didSet {
             self.didFinishDetail?()
           }
      }
         var error: Error? {
              didSet {
                 //self.showAlertClosure?()
                 
             }
          }
       // MARK: - Constructor
          init(dataService: DataService) {
            self.dataService = dataService
            selectedBackgroundView.backgroundColor = .clear
    }
     var didFinishDetail: (() -> ())?
        
       // MARK: - Network call
        func Movie_Detail(id: String)
        {
                  self.dataService?.Https_Detail(id: id,completion: { (M_Detail, error) in
                      
                       if let error = error{
                           self.error = error
                         
                           return
                       }
                       self.error = nil
                  
                  
                     if let detail = M_Detail
                     {
//bio
                        if let bio = detail.bio
                        {
                            self.items[bio_str] = bio
                            self.title_items.append(bio_str)
                        }
//name
                        if let people_name = detail.name
                        {
                             self.name = people_name
                        }
//login
                        if let login = detail.login
                        {
                             self.items[login_str] = login
                             self.title_items.append(login_str)
                        }
//location
                        if let location = detail.location
                        {
                            self.items[location_str] = location
                            self.title_items.append(location_str)
                        }
//blog
                        if let blog = detail.blog,detail.blog != ""
                        {
                             self.items[blog_str] = blog
                             self.title_items.append(blog_str)
                        }
                      
                        
                         self.Model_Detail = M_Detail
                     }
                  })
         }
         
   // }
}
// MARK: -  UITableView Delegate,DataSource
extension Detail_View_Model: UITableViewDataSource ,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(title_items[indexPath.row] == login_str||title_items[indexPath.row] == login_str||title_items[indexPath.row] == blog_str)
        {
            return 80.0 //Date_Cell height
        }
        else
        {
            return UITableView.automaticDimension
            //80
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
       if(title_items[indexPath.row] == bio_str)
       {
            if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: bio_Cell.self), for: indexPath) as? bio_Cell
            {
               cell.selectedBackgroundView = selectedBackgroundView
               cell.title.text = items[title_items[indexPath.row]]
               return cell
             }
       }
       else if(title_items[indexPath.row] == login_str)
       {
            if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: people_cell.self), for: indexPath) as? people_cell
            {
                cell.selectedBackgroundView = selectedBackgroundView
                if let badge = self.Model_Detail?.site_admin{
                    cell.staff_badge(badge_icon:badge)
                }
                else{
                    cell.staff_badge(badge_icon:false)
                }
                cell.title.text = items[title_items[indexPath.row]]
                return cell
            }
       }
       else
       {
           if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: detail_cell.self), for: indexPath) as? detail_cell
           {
              cell.selectedBackgroundView = selectedBackgroundView
              if(title_items[indexPath.row] == location_str)
              {
                if let location = self.Model_Detail?.location
                {
                     cell.title.text = location
                     cell.title.textColor = .black
                     cell.icon_img.image = UIImage(named:"location_icon")
                }
                
              }
              else
              {
                if let blog = self.Model_Detail?.blog
                {
                     cell.title.text = blog
                     cell.title.textColor = .blue
                     cell.icon_img.image = UIImage(named:"blog_icon")
                }
              }
              return cell
              
           }
        }

        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(title_items[indexPath.row] == blog_str)
        {
            if let blog = self.Model_Detail?.blog
            {
                guard delegate?.show_webview(path: blog) != nil else
                {
                     return print("the delegate is not set")
                }
            }
        }
  
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
       {
              cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
               UIView.animate(withDuration: 0.25, animations: {
                    cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
                })
       }

}
