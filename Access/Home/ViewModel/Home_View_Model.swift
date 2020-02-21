//
//  Home_View_Model.swift
//  Movie
//
//  Created by Yen on 2020/2/20.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher



class Home_View_Model: NSObject
{
// MARK: - parameter
    var end_Page = false
    var isLoading = false
    var total_pages:Int?
    var page_Num:Int = 0
    var last_page_Num:Int = 0
    var items = [M_Home]()
    {
        didSet{
         
          self.didFinishDiscover?()
        }
    }
    private var dataService: DataService?
 
// MARK: - Constructor
     init(dataService: DataService) {
       self.dataService = dataService
    }
    var model_home:[M_Home]?
    
    var error: Error? {
         didSet {
            //self.showAlertClosure?()
        }
     }

// MARK: - clousure
     var didFinishDiscover: (() -> ())?
     var didTapcell: (() -> ())?
    
// MARK: - Network call
    func Movie_Discover(Page: Int)
    {
           self.dataService?.Https_Discover(Page: Page,completion: { (M_Home, error) in
                
                if let error = error
                {
                    self.error = error
                    
                    return
                }
                self.error = nil
                 self.isLoading = false
            
                self.model_home = M_Home

                if let model_home = M_Home
                {
                    self.Parse_data(M_Home:model_home,Page: Page)
                }else
                {
                     print("model_home nil")
                }
           })
     }
    
    func Parse_data(M_Home:[M_Home],Page: Int)
    {

//
               if(Page  == 0)
               {
                    self.items = M_Home
                    last_page_Num = M_Home[M_Home.count-1].id!
                
               }
               else
               {

                   for i in 0..<M_Home.count
                   {
                     
                       self.items.append(M_Home[i])
                   }
                    last_page_Num = M_Home[M_Home.count-1].id!
                     
                   
               }
          
                
    }
    
    func loadMoreData()
    { 
        if !self.isLoading
        {
            self.isLoading = true
            page_Num += 1
          
                if (page_Num <= 5)
                {
                    Movie_Discover(Page:last_page_Num)
                }else
                {
                    end_Page = true
                    self.didFinishDiscover?()
                }
           
        }
    }
    
    
}

// MARK: - TableViewDelegate
extension Home_View_Model: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return items.count
        }
        else if section == 1
        {
            return end_Page ? 0 : 1
        } else {
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       if (indexPath.section == 0)
       {
           if let cell = tableView.dequeueReusableCell(withIdentifier:"Home_Cell_id", for: indexPath) as? Home_Cell
           {
//poster_path
                if  let  url_path = items[indexPath.row].avatar_url
                {
                    let articleUrl = URL(string: url_path)
                    cell.poster_img.kf.indicatorType = .activity
                    cell.poster_img.kf.setImage(with: articleUrl)
                }else
                {
                    cell.poster_img.image = UIImage(named: "No_Image")
                }
//title 
                if  let  title_lab = items[indexPath.row].login
                {
                     cell.title_label.text = title_lab
                }else
                {
                     cell.title_label.text = ""
                }
//site_admin
                if  let  admin = items[indexPath.row].site_admin
                {
                    cell.staff_badge(badge_icon: admin)
                }else
                {
                    cell.staff_badge(badge_icon: false)
                }

                    return cell
           }
        }
        else
        {
          if let cell = tableView.dequeueReusableCell(withIdentifier:"Loading_Cell_id", for: indexPath) as? Loading_Cell
           {
                cell.activityIndicator.startAnimating()
               
                return cell
            }
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         if let avatar = items[indexPath.row].avatar_url
         {
             G_avatar_url = avatar  
         }
         if let login_id = items[indexPath.row].login
         {
             G_detail_id = login_id
             self.didTapcell?()
         }
         
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 100.0 //Home_Cell height
        } else
        {
           return 70 //Loading Cell height
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
       let offsetY = scrollView.contentOffset.y
       let contentHeight = scrollView.contentSize.height
       if (offsetY > contentHeight - scrollView.frame.height ) && !isLoading
       {
           loadMoreData()
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


