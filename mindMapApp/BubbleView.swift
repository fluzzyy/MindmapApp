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
   
    private var label = UILabel()
   
    var text : String{
        get{
            return label.text!
            
        }set(str){
            label.text = str
            updateFrame()
        }
    }
    
    //MARK: Selected property
    
    var selected : Bool = false {
        didSet{
            setNeedsDisplay()
        }
    }
    
    let minSize: CGFloat = 80
    let maxWidth : CGFloat = 240
    let padding : CGFloat = 8


    
    // MARK: INIT
    
    init(_ atPoint: CGPoint) {
        
        
        let frame = CGRect(x: atPoint.x-minSize/2, y: atPoint.y-minSize/2, width: 80, height: 80)
        super.init(frame: frame)
        color = UIColor.random()
        backgroundColor = UIColor.clear
        
      
       // self.layer.cornerRadius = size/2
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
  
    func delete(){
        for line in lines{
            line.removeFromSuperview()
        }
        removeFromSuperview()
        
    }
    //MARK: Draw

    func updateFrame(){
        
        // beräkna frame för label och vy
        let labelSize = label.sizeThatFits(CGSize(width: maxWidth - padding * 2  ,
                                                  height: minSize - padding * 2))
        let bubbleWidth = max(minSize,
                              labelSize.width + padding * 2)
        
        label.frame = CGRect(x: padding,
                             y: padding,
                             width: bubbleWidth - 2 * padding,
                             height: minSize - 2 * padding)
        
        frame = CGRect(x: center.x - bubbleWidth / 2,
                       y: center.y - minSize / 2,
                       width: bubbleWidth,
                       height: minSize)
        
        setNeedsDisplay()
        
    }
 
    override func draw(_ rect: CGRect) {
    
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft,.topRight], cornerRadii: CGSize(width: bounds.size.width/2, height: bounds.size.height/2))
        //Villkor ? SANT : Falskt
        selected ? UIColor.yellow.setFill() : color?.setFill()
        path.fill()
        
        
    }
 

}

extension UIColor {
    
    static func random() -> UIColor{
        
        let randomRed = CGFloat(arc4random_uniform(256))/255.0
         let randomGreen = CGFloat(arc4random_uniform(256))/255.0
         let randomBlue = CGFloat(arc4random_uniform(256))/255.0
        
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
}
