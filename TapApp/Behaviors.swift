//
//  Behaviors.swift
//  TapApp
//
//  Created by Nguyen Tam Anh Bui on 2/2/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation
import UIKit

class Behaviors {
    
    var tappedView: UIView!

    init(view: UIView) {
        self.tappedView = view
        print("initialized Tapped view: -> ", tappedView)
    }
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: tappedView)
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
    
    func addBehaviors(view: UIView) {
        animator.removeAllBehaviors()
        
        // app crashes here!
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        
        // Add the subview to both behaviors
        collider.addItem(view)
        gravity.addItem(view)
    }
    
}
