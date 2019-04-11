//
//  ViewController.swift
//  mindMapApp
//
//  Created by Alexander Gunnarsson on 2019-04-11.
//  Copyright © 2019 Alexander Gunnarsson. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BubbleViewDelegate, UIScrollViewDelegate {
  
    

     var selectedBubble : BubbleView?
    var superScrollView : UIScrollView?
    var superContentView : UIView?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // configurerar scrollview
        superScrollView = UIScrollView(frame: view.bounds)
        superScrollView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        superScrollView?.delegate = self
        let contentSize : CGFloat = 2000
        superScrollView?.contentSize = CGSize(width: contentSize, height: contentSize)
        superScrollView?.contentOffset = CGPoint(x: contentSize - view.frame.size.width/2, y: view.frame.size.height/2)
        superScrollView?.minimumZoomScale = 0.5
        superScrollView?.maximumZoomScale = 2.0
        // konfigurera contentview
        superContentView = UIView(frame: CGRect(x: 0, y: 0, width: contentSize, height: contentSize))
        superScrollView?.addSubview(superContentView!)
        // lägga till vår scrollvy i vår container
        view.addSubview(superScrollView!)
        
        
        //  lägga till tapgesture för att skapa nya bubblor
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        superContentView!.addGestureRecognizer(tap)

    }
    func didEdit(_ bubble: BubbleView){
        let textInput = UIAlertController(title: "Edit bubble text", message: "Enter the text you want in the bubble", preferredStyle: .alert)
        textInput.addTextField { (TextField) in
           TextField.text = bubble.label.text
        }
        textInput.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let textField = textInput.textFields![0] as UITextField
             bubble.label.text = textField.text
        }))
        self.present(textInput, animated: true, completion: nil)
    }

    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        //Hitta CGPoint och lägg till bubbla.
                if selectedBubble != nil {
            selectedBubble?.deselect()
            selectedBubble = nil
        } else {
            let tapPoint = gesture.location(in: superContentView)
            let bubble = BubbleView(tapPoint)
            bubble.delegate = self
            superContentView!.addSubview(bubble)
            
        }
    }
    
    //MARK: BubbleviewDelegate
    func didSelect(_ bubbleView: BubbleView) {
        if selectedBubble != nil{
            if bubbleView == selectedBubble{
                //  delete bubble
                bubbleView.delete()
            }else{
                // Connect bubbles
                let line = LineView(from: selectedBubble!, to: bubbleView)
                superContentView!.insertSubview(line, at: 0)
                selectedBubble?.lines.append(line)
                bubbleView.lines.append(line)
            }
            //  Deselect selectedBubble
            selectedBubble?.deselect()
            selectedBubble = nil
            
        }else{
            
            selectedBubble = bubbleView
            selectedBubble?.select()
        }
    }
    
    //MARK:  UISCROLLVIEWdelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return superContentView!
    }
    
}

