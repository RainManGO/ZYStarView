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
    @IBOutlet weak var currentTextField: UITextField!
    @IBOutlet weak var starAllCountTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xibsetting()
    }
}

//MARK:- 你用到的starView代码
extension ViewController{
    
    //xib设置回调
    func xibsetting(){
        //选中星星数的回调
        starView.callback = { (selectStarCount) in
            print(selectStarCount)
        }
    }
    
    //纯代码
    func codeStart(){
        let starview = ZYStarRateView.init(frame: CGRect.init(x: (UIScreen.main.bounds.width - 320)/2, y: 600, width: 320, height: 100), starCount: 8, currentStar: 2, rateStyle: .half) { (current) -> (Void) in
            print(current)
        }
        self.view.addSubview(starview)
    }
}

//MARK:- 星星示例参数设置（示例代码可以不看）
extension ViewController:UITextFieldDelegate{
    
    //切换基本单位
    @IBAction func segmentControlSelect(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            starView.selectStarUnit = .all
            break
        case 1:
            starView.selectStarUnit = .half
            break
        case 2:
            starView.selectStarUnit = .custom
            break
        default:
            break
        }
        starView.update()
    }
    
    //总星数和当前星数设置
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let count = UInt(textField.text ?? "5"){
            if textField == starAllCountTextField {
                starView.numberOfStar = count
            }else{
                starView.selectNumberOfStar = Float(count)
            }
        }
        starView.update()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapViewEedEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        starView.update()
    }
    
    //是否支持动画
    @IBAction func isAnimationSwitch(_ sender: UISwitch) {
        starView.isAnimation = sender.isOn
        starView.update()
    }
    //是否支持点击
    @IBAction func isTapSwitch(_ sender: UISwitch) {
        starView.isSupportTap = sender.isOn
        print(starView.isSupportTap)
        starView.update()
    }
    
}

