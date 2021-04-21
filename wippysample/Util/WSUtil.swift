//
//  WSUtil.swift
//  wippysample
//
//  Created by Woncheol Heo on 2021/04/09.
//

import UIKit

class WSUtil: NSObject {
    @objc public class func UIColorFromRGB(rgbValue : Int, alphaDegree : CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0 ,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0 ,
                       blue: CGFloat((rgbValue & 0x0000FF)) / 255.0 ,
                       alpha: alphaDegree)
    }
}
