//
//  Detail_View.swift
//  Access
//
//  Created by Yen on 2020/2/20.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit
import Kingfisher


extension Detail_View: Detail_View_Model_Delegate
{
    func show_webview(path: String) {
         UIApplication.shared.open(URL(string:path)!)
    }
    
    
}
class Detail_View: UIViewController {

  
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Poster_img: UIImageView!
    fileprivate let ViewModel = Detail_View_Model(dataService: DataService())
    @IBOutlet weak var Detail_Tab: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        Poster_img.layer.masksToBounds = true
        Poster_img.layer.cornerRadius = Poster_img.frame.width/2
              
        AttemptDetail()
        SetPosterimg()
        SetupTableView()
    }


    override func viewWillAppear(_ animated: Bool)
       {
                super.viewWillAppear(animated)
               navigationController?.setNavigationBarHidden(true, animated: animated)
       }
// MARK: -  Function
        func SetPosterimg()
        {
            if let  base_url = G_avatar_url
            {
//read cache img
               
               let articleUrl = URL(string: base_url)
               let imageResource = ImageResource(downloadURL: articleUrl!, cacheKey: base_url)
               Poster_img.kf.setImage(with: imageResource)
            }
            else
            {
                Poster_img.image = UIImage(named:"No_Image")
            }
        }
        
        func SetupTableView()
        {
//TableView setup
            
            Detail_Tab?.separatorStyle = .none
            Detail_Tab.bounces = false
            Detail_Tab?.dataSource = ViewModel
            Detail_Tab?.delegate = ViewModel
            ViewModel.delegate = self
            
//Cell register
            let DetailCell_Nib = UINib(nibName: String(describing: detail_cell.self), bundle: nil)
            Detail_Tab.register(DetailCell_Nib, forCellReuseIdentifier: String(describing: detail_cell.self))
            
            let Bio_Nib = UINib(nibName: String(describing: bio_Cell.self), bundle: nil)
            Detail_Tab.register(Bio_Nib, forCellReuseIdentifier: String(describing: bio_Cell.self))
            
            let People_Nib = UINib(nibName: String(describing: people_cell.self), bundle: nil)
            Detail_Tab.register(People_Nib, forCellReuseIdentifier: String(describing: people_cell.self))

//Dynamic cell
            Detail_Tab.estimatedRowHeight = 25.0
            Detail_Tab.rowHeight = UITableView.automaticDimension
 
         }
// MARK: -  Networking call
         func AttemptDetail()
         {
          
            if let d_id = G_detail_id
            {
                 ViewModel.Movie_Detail(id: d_id)
            }
             
          
            ViewModel.didFinishDetail = { [weak self] () in
                      DispatchQueue.main.async {
                        self!.Detail_Tab.reloadData()
                        self!.name.text =  self?.ViewModel.name
                      }
                  }
              
        
         }
    // MARK: -  Return view
         @IBAction func Back(_ sender: Any)
         {
              self.navigationController?.popViewController(animated: true)
         }

}
