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
                bubbleView.delete()
            }else{
                // COnnect bubbles
                let line = LineView(from: selectedBubble!, to: bubbleView)
                view.insertSubview(line, at: 0)
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
    
   
}

