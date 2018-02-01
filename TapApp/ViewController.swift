//
//  ViewController.swift
//  TapApp
//
//  Created by Nguyen Tam Anh Bui on 1/29/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK : SETUP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK : Properties
    
    @IBOutlet var tappedView: UIView!

    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.tappedView)
    }()
    
    lazy var collider:UICollisionBehavior = {
        let lazyCollider = UICollisionBehavior()
        // This line, makes the boundries of our reference view a boundary
        // for the added items to collide with.
        lazyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazyCollider
    }()
    
    lazy var gravity: UIGravityBehavior = {
        let lazyGravity = UIGravityBehavior()
        return lazyGravity
    }()
    
    
    // MARK : private methods
    
    private func addPanGesture(view: UIView) {
        print("adding a pangesture to the subview")
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
            addBehaviors(view: shapeView)
        default:
            break
        }
    
    }
    
    private func addBehaviors(view: UIView) {
        animator.removeAllBehaviors()
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        
        // Add the subview to both behaviors
        collider.addItem(view)
        gravity.addItem(view)
    }
    
    // Does all the necessary setup for the given shape / UIView
    private func setupShapeView(view: UIView) {
        // adding a pangesture to the subview
        addPanGesture(view: view)
        view.isUserInteractionEnabled = true
        addBehaviors(view: view)
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

