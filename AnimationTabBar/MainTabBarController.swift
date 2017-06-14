//
//  MainTabBarController.swift
//  AnimationTabBar
//
//  Created by Edward on 2017/6/14.
//  Copyright © 2017年 钟进. All rights reserved.
//

import UIKit

class MainTabBarController: AnimationTabBarController, UITabBarControllerDelegate {
    
    fileprivate var firstLoadMainTabBarController:Bool = true
    fileprivate var adImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        createMainTabBarChildViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstLoadMainTabBarController {
            let containers = createViewContainers()
            
            createCustomIcons(containers)
            firstLoadMainTabBarController = false
        }
    }
    
    //MARK: - 初始化tabbar
    fileprivate func createMainTabBarChildViewController() {
        tabBarControllerAddChildViewController(HomeViewController(), title: "首页", imageName: "v2_home", selectedImageName: "v2_home_r", tag: 0)
        tabBarControllerAddChildViewController(MarketViewController(), title: "超市", imageName: "v2_order", selectedImageName: "v2_order_r", tag: 1)
        tabBarControllerAddChildViewController(ShopViewController(), title: "商店", imageName: "shopCart", selectedImageName: "shopCart", tag: 2)
        tabBarControllerAddChildViewController(MeViewController(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r", tag: 3)
        
    }
    
    fileprivate func tabBarControllerAddChildViewController(_ childView: UIViewController, title: String, imageName: String, selectedImageName: String, tag: Int) {
        
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vcItem.tag = tag
        vcItem.animation = RAMBounceAnimation()
        childView.tabBarItem = vcItem
        
        let navigationVC = BaseNavigationController(rootViewController:childView)
        addChildViewController(navigationVC)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let childArr = tabBarController.childViewControllers as NSArray
//        let index = childArr.index(of: viewController)
//        
//        if index == 2 {
//            return false
//        }
        return true
    }

}
