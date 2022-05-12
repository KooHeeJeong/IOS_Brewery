//
//  BearListViewController.swift
//  Brewery
//
//  Created by 구희정 on 2022/05/12.
//

import UIKit

class BearListViewController : UITableViewController {
    var bearList = [Bear]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigation Bar
        title = "구희정의 맥주추천"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

//UItableView DataSource , Delegate
extension BearListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bearList.count
    }
}
