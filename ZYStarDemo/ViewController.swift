//
//  ViewController.swift
//  ZYStarDemo
//
//  Created by Nvr on 2018/3/26.
//  Copyright © 2018年 Nvr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var starView: ZYStarRateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        starView.selectStarUnit = .custom
        starView.selectNumberOfStar = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

