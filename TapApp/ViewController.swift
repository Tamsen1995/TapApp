//
//  ViewController.swift
//  TapApp
//
//  Created by Nguyen Tam Anh Bui on 1/29/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK : Properties
    
    @IBOutlet var tappedView: UIView!
    var behaviors: Behaviors!
    // MARK : SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.behaviors = Behaviors(view: self.tappedView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK : private methods
    
    @IBAction private func resetAllViews(_ sender: UIButton) {
        self.view.subviews.forEach({
            if $0 != sender && $0 != self.tappedView {
                $0.removeFromSuperview()
            }
        })
        self.behaviors = nil
        self.behaviors = Behaviors(view: self.tappedView)
        print("\n\n\n")
    }

    private func addPanGesture(view: UIView) {
        print("adding a pan gesture to the subview")
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        let shapeView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            shapeView.center = CGPoint(x: shapeView.center.x + translation.x, y: shapeView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            behaviors.addBehaviors(view: shapeView)
        default:
            break
        }
    
    }
    
    private func addPinchGesture(view: UIView) {
        print("adding a pinch gesture to the subview")
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.handlePinch(sender:)))
        view.addGestureRecognizer(pinch)
    }
    
    @objc private func handlePinch(sender: UIPinchGestureRecognizer) {
        let shapeView = sender.view!

        switch sender.state {
        case .began, .changed:
            shapeView.transform = (shapeView.transform.scaledBy(x: sender.scale, y: sender.scale))
            sender.scale = 1.0
        case .ended:
            shapeView.bounds = shapeView.frame
            behaviors.addBehaviors(view: shapeView)
        default:
            break
        }
    }
    
    // Does all the necessary setup for the given shape / UIView
    
    private func setupShapeView(view: UIView) {
        view.isUserInteractionEnabled = true
        addPanGesture(view: view)
        addPinchGesture(view: view)
        behaviors.addBehaviors(view: view)
    }
    
    @IBAction private func tapHandler(_ sender: UITapGestureRecognizer) {
        let tappedLocation: CGPoint = sender.location(in: tappedView)
        let subview: Tapped = Tapped()
        let framesize: CGFloat = 50
        subview.frame = CGRect(x: tappedLocation.x - framesize / 2 ,y: tappedLocation.y - framesize / 2 ,width: framesize ,height: framesize)
        subview.backgroundColor = UIColor.clear
        self.view.addSubview(subview)
        setupShapeView(view: subview)
    }
    

    
}

