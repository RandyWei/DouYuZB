//
//  NormalRoomViewController.swift
//  DouYuZB
//
//  Created by Wei on 2019/9/20.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class NormalRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
       
    }

}
