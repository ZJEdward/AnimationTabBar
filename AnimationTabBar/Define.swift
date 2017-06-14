//
//  Define.swift
//  AnimationTabBar
//
//  Created by Edward on 2017/6/13.
//  Copyright © 2017年 钟进. All rights reserved.
//

import UIKit

//MARK:- NOTIFICATION
public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"


// MARK:- Colors
public let GlobalBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)

//MARK:- FRAME
public let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds:CGRect = UIScreen.main.bounds

extension UIColor {
    
    class func colorWithCustom(_ r:CGFloat, g:CGFloat, b:CGFloat)->UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}

extension UIView {
    
    var x:CGFloat {
        return self.bounds.origin.x
    }
    var y:CGFloat {
        return self.bounds.origin.y
    }
    var width:CGFloat {
        return self.bounds.size.width
    }
    var height:CGFloat {
        return self.bounds.size.height
    }
    var size: CGSize {
        return self.bounds.size
    }
    var point:CGPoint {
        return self.frame.origin
    }
    
}

