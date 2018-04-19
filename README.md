# ZYStarView

介绍
==============
Swift星星显示、选择的封装
XIb和纯代码均可使用（XIb体验极佳）


功能支持
==============
- **星数设置**: 在一块区域均分显示想要设定的星星
- **设置星数计算单位**:支持一星、半星、随意float定制显示
- **显示动画设置**: 点击星星显示动画
- **回调**: 星数设置完之后会返回当前星数作为回调
- **支持xib**: xib storyBoard 创建直接对应类即可.属性支持keyPath


代码使用方法
==============
```objc
// 创建starView并回调当前选中星数，参数说明看备注很清楚
let starview = ZYStarRateView.init(frame: CGRect.init(x: (UIScreen.main.bounds.width - 320)/2, y: 600, width: 320, height: 100), starCount: 8, currentStar: 2, rateStyle: .half) { (current) -> (Void) in
print(current)
}
```

XIB代码使用方法
==============
灰常简单，如果只是显示不要回调不需要写代码。
![image](https://github.com/RainManGO/ZYStarView/blob/master/2406D2E1-E0E9-4928-BA60-38A5EBBFAB9B.png)



演示
==============
![image](https://github.com/RainManGO/ZYStarView/blob/master/ZyStarView.gif)


更新
==============
修复xib 在 uitablewview 布局不准确问题
