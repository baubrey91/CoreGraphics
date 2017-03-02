//
//  GraphView.swift
//  coreGraphicsTest
//
//  Created by Brandon on 2/28/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {


    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    var graphPoints:[Int] = [4,2,6,4,5,8,3]

    
    override func draw(_ rect: CGRect) {
        
        
        let width = rect.width
        let height = rect.height
        
        //set up background clipping area
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: UIRectCorner.allCorners,
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        
        path.addClip()
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        
        currentContext.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        guard let startColorComponents = startColor.cgColor.components else { return }
        
        guard let endColorComponents = endColor.cgColor.components else { return }
        
        let colorComponents: [CGFloat]
            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        let locations:[CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2) else { return }
        
        currentContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        currentContext.restoreGState()
        
        let margin: CGFloat = 20.0
        let columnXPoint = { (column:Int) -> CGFloat in
    
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()// made change
        let columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        let graphPath = UIBezierPath()
        
        graphPath.move(to: CGPoint(x: columnXPoint(0), y:columnYPoint(graphPoints[0])))
        
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
 
        
        currentContext.saveGState()
        
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        
        clippingPath.close()
        
        clippingPath.addClip()
        
        
        let highestYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        currentContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        currentContext.restoreGState()

        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        
 
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
 

        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x:margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin,
                                     y:topBorder))
        linePath.move(to: CGPoint(x:margin,
                                  y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x:width - margin,
                                     y:graphHeight/2 + topBorder))
        
        linePath.move(to: CGPoint(x:margin,
                                  y:height - bottomBorder))
        linePath.addLine(to: CGPoint(x:width - margin,
                                     y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }
}
