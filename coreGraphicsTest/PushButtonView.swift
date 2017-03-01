//
//  PushButtonView.swift
//  coreGraphicsTest
//
//  Created by Brandon on 2/28/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

@IBDesignable

class PushButtonView: UIButton {
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var isAddButton: Bool = true

    override func draw(_ rect: CGRect) {
        
        var path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        //create the path
        var plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        
        //set the path's line width to the height of the stroke
        plusPath.addLine(to: CGPoint(x: bounds.width/2 + plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        
        //Vertical Line
        
        if isAddButton {
            //move to the start of the vertical stroke
            plusPath.move(to: CGPoint(x:bounds.width/2 + 0.5, y:bounds.height/2 - plusWidth/2 + 0.5))
            
            //add the end point to the vertical stroke
            plusPath.addLine(to: CGPoint(x:bounds.width/2 + 0.5, y:bounds.height/2 + plusWidth/2 + 0.5))
        }
        //set the path's line width to the height of the stroke
        UIColor.white.setStroke()
        
        //set the path's line width to the height of the stroke
        plusPath.stroke()
    }


}
