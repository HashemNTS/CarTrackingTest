//
//  Styler.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/31/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import Foundation
import  UIKit

class Styler
{
    static func BorderRad(target:UIView,Radus:CGFloat,borderWidth:CGFloat,BorderColor:UIColor? = nil)
    {
        target.layer.borderWidth = borderWidth
        target.layer.cornerRadius = Radus
        target.clipsToBounds = true;
        if let BorderColor = BorderColor
        {
            target.layer.borderColor = BorderColor.cgColor;
        }
    }
}
