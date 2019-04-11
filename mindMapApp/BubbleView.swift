//
//  BubbleView.swift
//  mindMapApp
//
//  Created by Alexander Gunnarsson on 2019-04-11.
//  Copyright © 2019 Alexander Gunnarsson. All rights reserved.
//

import UIKit


protocol BubbleViewDelegate {
    func didSelect(_ bubbleView : BubbleView)
    
    
}


class BubbleView: UIView {
    
    var lines = [LineView]()
    var delegate : BubbleViewDelegate?
    
    // MARK: INIT
    
    init(_ atPoint: CGPoint) {
        
        
        let size: CGFloat = 80
        let frame = CGRect(x: atPoint.x-size/2, y: atPoint.y-size/2, width: 80, height: 80)
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        self.layer.cornerRadius = size/2
        self.clipsToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanInBubble(_:)))
        self.addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapInBubble(_:)))
        self.addGestureRecognizer(tap)
        //Skapa en label för din bubbla
        let label = UILabel(frame: bounds)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Text"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Gestures
    
    @objc func didPanInBubble(_ gesture : UITapGestureRecognizer){
        
        if gesture.state == .changed{
            
            self.center = gesture.location(in: superview)
            
            for line in lines{
                line.update()
            }
        }
        
    }
    
    
    @objc func didTapInBubble(_ gesture : UITapGestureRecognizer){
        guard let bubble = gesture.view as? BubbleView else {return}
        if delegate != nil{
            delegate!.didSelect(bubble)
        }
       
        
    }
    //MARK: Draw

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
