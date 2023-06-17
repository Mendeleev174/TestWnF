//
//  CustomAnyButton.swift
//  TestWnF
//
//  Created by Александр Щербинин on 17.06.2023.
//

import UIKit

class CustomAnyButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }

}
