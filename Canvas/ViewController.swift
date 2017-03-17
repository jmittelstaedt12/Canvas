//
//  ViewController.swift
//  Canvas
//
//  Created by Jacob Mittelstaedt on 3/16/17.
//  Copyright © 2017 Jacob Mittelstaedt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var newImage: UIImageView?

    
    @IBOutlet weak var trayView: UIView!
    
    
    @IBAction func onSmileyPanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began{
            let panImage = sender.view as! UIImageView
            let new = UIImageView(image: panImage.image)
            new.center = panImage.center
            newImage = new
            view.addSubview(new)
        } else if sender.state == .changed{
            newImage?.center = sender.location(in: view)
        } else if sender.state == .ended {
            newImage = nil
        }
        
        
    }
    
    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        let location: CGPoint = sender.location(in: view)
        
        if sender.state == .began {
            //NSLog("Gesture began at: %@", NSStringFromCGPoint(location))
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            //NSLog("Gesture changed at: %@", NSStringFromCGPoint(location));
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + sender.translation(in: view).y)
        } else if sender.state == .ended {
            //NSLog("Gesture ended at: %@", NSStringFromCGPoint(location));
            if sender.velocity(in: view).y > 0{
                trayCenterWhenOpen = sender.location(in: view)
                UIView.animate(withDuration: 0.2, animations: {
                    self.trayView.center.y = 651
                })
            } else{
                trayCenterWhenClosed = sender.location(in: view)
                UIView.animate(withDuration: 0.2, animations: {
                    self.trayView.center.y = 455
                })
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

