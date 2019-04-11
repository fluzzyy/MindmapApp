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
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        fromView = from
        toView = to
        update()
        
    }
    
    func update(){
        // TODO: beräkna ny frame och kalla på utritning
        if fromView != nil && toView != nil {
             self.frame = fromView!.frame.union(toView!.frame)/*.insetBy(dx: fromView!.frame.size.width/2, dy: fromView!.frame.size.height/2)*/
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    

        /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
