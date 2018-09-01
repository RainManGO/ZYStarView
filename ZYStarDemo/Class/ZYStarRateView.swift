//
//  ZYStarRateView.swift
//  ZYDemo
//
//  Created by zy on 2018/3/26.
//  Copyright © 2018年 zy. All rights reserved.
//

import UIKit


/// 星星计算单位
///
/// - all: 一星计算
/// - half: 半星计算
/// - custom: 随意
enum rateStyle: Int {
    case  all     = 0
    case  half    = 1
    case  custom  = 2
}

//计算显示完回调方法
typealias CountCompleteBackBlock = (_ currentCount:Float)->(Void)

public class ZYStarRateView: UIView {
    
    //MARK:- 属性 支持xib Path
    
    //星星的总量,默认是5星
    @objc public var numberOfStar:UInt = 5
    //当前选中的数量，默认不选中
    @objc public var selectNumberOfStar:Float = 0{
        didSet{
            //不重复刷新
            if oldValue == selectNumberOfStar {
                return
            }
            //越界处理
            if selectNumberOfStar < 0 {
                 selectNumberOfStar = 0
            }else if selectNumberOfStar > Float(numberOfStar){
                 selectNumberOfStar = Float(numberOfStar)
            }
            
            if let currentStarBack = callback {
                currentStarBack(selectNumberOfStar)
            }
            layoutSubviews()
        }
    }
    //是否支持动画
    @objc public var isAnimation:Bool = true
    //是否支持点击选择
    @objc public var isSupportTap:Bool = true
    
    //回调函数
    public var callback:CountCompleteBackBlock?
    //选择单位 默认全选
    public var selectStarUnit:rateStyle = .all
    //背景view
    fileprivate var backgroundView:UIView!
    //选择view
    fileprivate var foreView:UIView!
    //星星的宽度
    fileprivate var starWidth:CGFloat!
    
    
    //MARK:- veiw系统方法

    //系统代码初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    ///  遍历初始函数
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - starCount: 背景星星个数
    ///   - currentStar: 当前星星个数
    ///   - rateStyle:选择单位 默认全选
    ///   - isAnimation: 是否支持动画
    convenience init(frame: CGRect,starCount:UInt?,currentStar:Float?,rateStyle:rateStyle?,isAnimation:Bool? = true,complete:@escaping CountCompleteBackBlock) {
        self.init(frame: frame)
        callback = complete
        numberOfStar = starCount ?? 5
        selectNumberOfStar = currentStar ?? 0
        selectStarUnit = rateStyle ?? .all
        self.isAnimation = isAnimation!
        setupUI()
    }
    
    //xib使用初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        let animationTimeInterval = isAnimation ? 0.2 : 0
        UIView.animate(withDuration: animationTimeInterval) {
            self.foreView.frame = CGRect(x: 0, y: 0, width: self.starWidth * CGFloat(self.selectNumberOfStar), height: self.bounds.size.height)
        }
    }
    
}


//MARK:- UI
extension ZYStarRateView{
    
    
    //重新设置属性刷新
    public func update() {
        setupUI()
    }
    
    //UI初始化
    fileprivate func setupUI(){
        
        clearAll()
        //星星宽度
        starWidth =  self.bounds.size.width/CGFloat(numberOfStar)
        //背景view
        self.backgroundView = self.creatStarView(image: #imageLiteral(resourceName: "star_bg"))
        //选择view
         self.foreView = self.creatStarView(image: #imageLiteral(resourceName: "star_fore"))
        
        self.foreView.frame = CGRect(x: 0, y: 0, width: starWidth * CGFloat(selectNumberOfStar), height: self.bounds.size.height)
        self.addSubview(self.backgroundView)
        self.addSubview(self.foreView)
        setTap()
    }
    
   fileprivate func setTap() {
        if isSupportTap {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ZYStarRateView.tapStar(sender:)))
            self.addGestureRecognizer(tap)
        }
    }
    
    //创建StarView
    fileprivate func creatStarView(image:UIImage) -> UIView {
        
        let view =  UIView(frame:self.bounds)
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        
        for i in 0...numberOfStar {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x:CGFloat(i) * starWidth, y: 0, width: starWidth, height: self.bounds.size.height)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
        }
        
        return view
    }
    
    //清除所有视图和手势
    func clearAll(){
        
        for view in self.subviews{
            view.removeFromSuperview()
        }
        
        if let taps = self.gestureRecognizers {
            for tap in taps{
                self.removeGestureRecognizer(tap)
            }
        }
       
    }
}

//MARK:- 事件
extension ZYStarRateView{
    
    @objc func tapStar(sender:UITapGestureRecognizer){
        let  tapPoint = sender.location(in: self)
        let  offset   = tapPoint.x
        let  selctCount = offset/starWidth
        switch selectStarUnit {
        case .all:
            selectNumberOfStar = ceilf(Float(selctCount))
            break
        case .half:
            selectNumberOfStar = roundf(Float(selctCount)) > Float(selctCount) ? ceilf(Float(selctCount)) :  ceilf(Float(selctCount)) - 0.5
            break
        default:
            selectNumberOfStar = Float(selctCount)
            break
        }
    }
}

