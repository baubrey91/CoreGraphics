//
//  CounterView.swift
//  coreGraphicsTest
//
//  Created by Brandon on 2/28/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let pi:CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {

    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <= NoOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth: CGFloat = 76
        
        let startAngle: CGFloat = 3 * pi / 4
        let endAngle: CGFloat = pi / 4

        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Draw the outline
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * pi - startAngle + endAngle
        
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        var outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArc(withCenter: center,
                                     radius: bounds.width/2 - arcWidth + 2.5,
                                     startAngle: outlineEndAngle,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        //4 - close the path
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        //Counter View markers
        
        let context = UIGraphicsGetCurrentContext()
        
        //1 - save original state
        context?.saveGState()
        outlineColor.setFill()
        
        let markerWidth:CGFloat = 5.0
        let markerSize:CGFloat = 10.0
        
        //2 - the marker rectangle positioned at the top left
        var markerPath = UIBezierPath(rect:
            CGRect(x: -markerWidth/2,
                   y: 0,
                   width: markerWidth,
                   height: markerSize))
        
        //3 - move top left of context to the previous center position
        context!.translateBy(x: rect.width/2,
                             y: rect.height/2)
        
        for i in 1...NoOfGlasses {
            //4 - save the centred context
            context!.saveGState()
            
            //5 - calculate the rotation angle
            var angle = arcLengthPerGlass * CGFloat(i) + startAngle - pi/2
            
            //rotate and translate
            context!.rotate(by: angle)
            context!.translateBy(x: 0,
                                 y: rect.height/2 - markerSize)
            
            //6 - fill the marker rectangle
            markerPath.fill()
            
            //7 - restore the centred context for the next rotate
            context!.restoreGState()
        }
        
        //8 - restore the original state in case of more painting
        context!.restoreGState()
        
    }
 

}
