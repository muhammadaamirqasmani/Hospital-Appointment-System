//
//  CustomizeButton.swift
//  Hospital Appointment System
//
//  Created by admin on 06/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CumtomizeButton: UIButton {
    
    @IBInspectable var  cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
}
