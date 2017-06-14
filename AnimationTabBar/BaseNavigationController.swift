//
//  BaseNavigationController.swift
//  AnimationTabBar
//
//  Created by Edward on 2017/6/13.
//  Copyright © 2017年 钟进. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    var isAnimation = true
    
    let backBtn: UIButton = {
    
        //设置返回按钮属性
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.setImage(UIImage(named: "v2_goback"), for: UIControlState())
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action: #selector(BaseNavigationController.backBtnClick), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = .left
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50:44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        
        return backBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = nil
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.navigationItem.hidesBackButton = true
        if childViewControllers.count > 0 {
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func backBtnClick() {
        
        popViewController(animated: isAnimation)
    }

}
