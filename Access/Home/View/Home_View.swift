//
//  ViewController.swift
//  Access
//
//  Created by Yen on 2020/2/20.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class Home_View: UIViewController {

    fileprivate let ViewModel = Home_View_Model(dataService: DataService())
    let RefreshControl = UIRefreshControl()
    @IBOutlet weak var Home_Table: UITableView!
           
    // MARK: - ViewLifeCycle
        override func viewDidLoad()
        {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            setUpTableView()
            AttemptDiscover()
            
        }
        override func viewWillAppear(_ animated: Bool)
        {
            super.viewWillAppear(animated)
             navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    // MARK: -  Function
         func setUpTableView()
         {
    //TableView setup
             Home_Table?.separatorStyle = .none
          //   Home_Table.backgroundColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0)
             Home_Table?.dataSource = ViewModel
             Home_Table?.delegate = ViewModel
       
    //Cell register
            let HomeCellNib = UINib(nibName: "Home_Cell", bundle: nil)
            Home_Table.register(HomeCellNib, forCellReuseIdentifier: "Home_Cell_id")
            
            let loadingCellNib = UINib(nibName: "Loading_Cell", bundle: nil)
            Home_Table.register(loadingCellNib, forCellReuseIdentifier: "Loading_Cell_id")

        }
         func AttemptDiscover()
        {
               
            ViewModel.Movie_Discover(Page:0)
                  

            
            ViewModel.didFinishDiscover = { [weak self] () in
                DispatchQueue.main.async {
                    self?.Home_Table.reloadData()
                    self?.RefreshControl.endRefreshing()
                }
            }
            
            ViewModel.didTapcell =
            {
//                let View = Detail_View()
//                self.navigationController?.pushViewController(View, animated: true)
            }
             
         }
      


}

