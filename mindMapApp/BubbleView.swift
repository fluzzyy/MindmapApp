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
    func didEdit(_ bubbleView : BubbleView)
    
}


class BubbleView: UIView {
    
    var lines = [LineView]()
    var delegate : BubbleViewDelegate?
    var color : UIColor?
    var label = UILabel()
    
    // MARK: INIT
    
    init(_ atPoint: CGPoint) {
        
        
        let size: CGFloat = 80
        let frame = CGRect(x: atPoint.x-size/2, y: atPoint.y-size/2, width: 80, height: 80)
        super.init(frame: frame)
        backgroundColor = UIColor.random()
        
      
        self.layer.cornerRadius = size/2
        self.clipsToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanInBubble(_:)))
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapInBubble(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        
        
        self.addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapInBubble(_:)))
        self.addGestureRecognizer(tap)
        
        //Skapa en label för din bubbla
        label.frame = bounds
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Text"
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
        }else if gesture.state == .began{
            superview?.bringSubviewToFront(self)
        }
        
    }
    @objc func didDoubleTapInBubble(_ gesture: UITapGestureRecognizer) {
        print("did double tap in bubble")
        
        guard  let bubble = gesture.view as? BubbleView else {
            return
        }
        if delegate != nil {
            delegate!.didEdit(bubble)
        }
        
        
    }
    
    
    @objc func didTapInBubble(_ gesture : UITapGestureRecognizer){
        guard let bubble = gesture.view as? BubbleView else {return}
        if delegate != nil{
            delegate!.didSelect(bubble)
        }
    }
    func select(){
        color = backgroundColor
        backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    func deselect(){
        backgroundColor = color
        
    }
    func delete(){
        for line in lines{
            line.removeFromSuperview()
        }
        removeFromSuperview()
        
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

extension UIColor {
    
    static func random() -> UIColor{
        
        let randomRed = CGFloat(arc4random_uniform(256))/255.0
         let randomGreen = CGFloat(arc4random_uniform(256))/255.0
         let randomBlue = CGFloat(arc4random_uniform(256))/255.0
        
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
}
