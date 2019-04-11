//
//  ViewController.swift
//  mindMapApp
//
//  Created by Alexander Gunnarsson on 2019-04-11.
//  Copyright © 2019 Alexander Gunnarsson. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BubbleViewDelegate {
  
    

     var selectedBubble : BubbleView?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  lägga till tapgesture för att skapa nya bubblor
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tap)

    }

    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        //Hitta CGPoint och lägg till bubbla.
                if selectedBubble != nil {
            selectedBubble?.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            selectedBubble = nil
        } else {
            let tapPoint = gesture.location(in: view)
            let bubble = BubbleView(tapPoint)
            bubble.delegate = self
            view.addSubview(bubble)
            
        }
    }
    
    //MARK: BubbleviewDelegate
    func didSelect(_ bubbleView: BubbleView) {
        if selectedBubble != nil{
            if bubbleView == selectedBubble{
                //  delete bubble
                bubbleView.removeFromSuperview()
            }else{
                //TODO: COnnect bubbles
                let line = LineView(from: selectedBubble!, to: bubbleView)
                view.insertSubview(line, at: 0)
                selectedBubble?.lines.append(line)
                bubbleView.lines.append(line)
            }
            //  Deselect selectedBubble
            selectedBubble?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            selectedBubble = nil
            
        }else{
            
            selectedBubble = bubbleView
            selectedBubble?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
    }
    
   
}

