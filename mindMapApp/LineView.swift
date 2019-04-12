//
//  LineView.swift
//  mindMapApp
//
//  Created by Alexander Gunnarsson on 2019-04-11.
//  Copyright © 2019 Alexander Gunnarsson. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    var fromView : BubbleView?
    var toView : BubbleView?
    
    init(from : BubbleView, to : BubbleView) {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        fromView = from
        toView = to
        update()
        
    }
    
    func update(){
        //  beräkna ny frame och kalla på utritning
        if fromView != nil && toView != nil {
             frame = fromView!.frame.union(toView!.frame)/*.insetBy(dx: fromView!.frame.size.width/2, dy: fromView!.frame.size.height/2)*/
            self.setNeedsDisplay()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    

    
   
    override func draw(_ rect: CGRect) {

            let path = UIBezierPath()
            let origin = fromView!.center - frame.origin
            let destination = toView!.center - frame.origin
            let controlVector = CGPoint (x: (destination.x - origin.x) * 0.5, y: 0)
        
            path.move(to: origin) // förflytta sig till startpunkt
            path.addCurve(to: destination, controlPoint1: origin + controlVector, controlPoint2: destination - controlVector)
            path.lineWidth = 2
            fromView?.color?.setStroke()
            path.stroke()

    }
}

func + (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}



func - (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

