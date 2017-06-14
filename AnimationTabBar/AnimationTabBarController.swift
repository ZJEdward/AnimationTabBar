//
//  AnimationTabBarController.swift
//  AnimationTabBar
//
//  Created by Edward on 2017/6/14.
//  Copyright © 2017年 钟进. All rights reserved.
//

import UIKit

class AnimationTabBarController: UITabBarController {

    var iconsView:[(icon: UIImageView, textLabel: UILabel)] = []
    var iconsImageName:[String] = ["v2_home", "v2_order", "shopCart", "v2_my"]
    var iconsSelectedImageName:[String] = ["v2_home_r", "v2_order_r", "shopCart_r", "v2_my_r"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //创建items的具体内容
    func createCustomIcons(_ containers: [String: UIView]) {
        
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                
                assert(item.image != nil, "add image icon in UITabBarItem")
                guard let container = containers["container\(index)"] else {
                    print("No container given")
                    continue
                }
                container.tag = index
                
                let imageW:CGFloat = 21
                let imageX:CGFloat = (ScreenWidth / CGFloat(items.count) - imageW) * 0.5
                let imageY:CGFloat = 8
                let imageH:CGFloat = 21
                let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
                icon.image = item.image
                icon.tintColor = UIColor.clear
                
                let textLabel = UILabel ()
                textLabel.frame = CGRect(x: 0, y: 32, width: ScreenWidth / CGFloat(items.count), height: 49 - 32)
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clear
                textLabel.font = UIFont.systemFont(ofSize: 10)
                textLabel.textAlignment = NSTextAlignment.center
                textLabel.textColor = UIColor.gray
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(icon)
                container.addSubview(textLabel)
                
                if let tabBarItem = tabBar.items {
                    let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count)
                    textLabel.bounds.size.width = textLabelWidth
                }
                
                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)
                
                item.image = nil
                item.title = ""
                
                if index == 0 {
                    selectedIndex = 0
                    selectItem(0)
                }
            }
        }
    }
    
    //选择item时item中内容的变化
    func selectItem(_ index: Int) {
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let selectIcon = iconsView[index].icon
        selectIcon.image = UIImage(named: iconsSelectedImageName[index])!
        items[index].selectedState(selectIcon, textLabel: iconsView[index].textLabel)
    }

    
    
    //重写父类的didSelectItem
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        setSelectIndex(fromIndex: selectedIndex, toIndex: item.tag)
    }
    
    //根据选择的index值设置item中的内容并且执行动画父类中的方法
    func setSelectIndex(fromIndex: Int, toIndex: Int) {
        
        selectedIndex = toIndex
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        
        let fromIV = iconsView[fromIndex].icon
        fromIV.image = UIImage(named: iconsImageName[fromIndex])
        items[fromIndex].deselectAnimation(fromIV, textLabel: iconsView[fromIndex].textLabel)
        
        let toIV = iconsView[toIndex].icon
        toIV.image = UIImage(named: iconsSelectedImageName[toIndex])
        items[toIndex].playAnimation(toIV, textLabel: iconsView[toIndex].textLabel)
    }
    
    func createViewContainers() -> [String: UIView] {
        
        var containersDict = [String: UIView]()
        
        guard let customItems = tabBar.items as? [RAMAnimatedTabBarItem] else {
            
            return containersDict
        }
        
        for index in 0..<customItems.count {
            
            let viewContainer = createViewContainer(index)
            containersDict["container\(index)"] = viewContainer
        }
        
        return containersDict
    }
    
    func createViewContainer(_ index: Int) -> UIView {
        
        let viewWidth: CGFloat = ScreenWidth / CGFloat(tabBar.items!.count)
        let viewHeight: CGFloat = tabBar.height
        let viewContainer = UIView(frame: CGRect(x: viewWidth * CGFloat(index), y: 0, width: viewWidth, height: viewHeight))
        
        viewContainer.backgroundColor = UIColor.clear
        viewContainer.isUserInteractionEnabled = true
        
        tabBar.addSubview(viewContainer)
        viewContainer.tag = index
        
        //给容器添加手势,其实是自己重写了系统的item的功能,因为我们要在里面加入动画
        let tap = UITapGestureRecognizer(target: self, action: Selector("tabBarClick:"))
        viewContainer.addGestureRecognizer(tap)
        return viewContainer

    }

    
}

class RAMAnimatedTabBarItem: UITabBarItem {
    
    var animation: RAMItemAnimation?
    var textColor = UIColor.gray
    
    func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        
        guard let animation = animation else {
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel)
    }
    
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel) {
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectedState(_ icon: UIImageView, textLabel: UILabel) {
         animation?.selectedState(icon , textLabel: textLabel)
    }
    
}

protocol RAMItemAnimationProtocol {
    func playAnimation(_ icon: UIImageView, textLabel:UILabel)
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor)
    func selectedState(_ icon: UIImageView, textLabel: UILabel)
}

class RAMItemAnimation:NSObject, RAMItemAnimationProtocol {
    
    var duration: CGFloat = 0.6
    var textSelectedColor: UIColor = UIColor.colorWithCustom(254, g: 213, b: 48)
    var iconSelectedColor: UIColor?
    
    func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        
    }
    
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        
    }
    
    func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        
    }
}

class RAMBounceAnimation: RAMItemAnimation {

    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        
        playBounceAnimation(icon, textLabel)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
        }
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    func playBounceAnimation(_ icon: UIImageView, _ textLabel: UILabel) -> () {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
        textLabel.layer.add(bounceAnimation, forKey: "bounceAnimation")
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
        
    }
}

