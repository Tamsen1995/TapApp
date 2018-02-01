//
//  Tapped.swift
//  TapApp
//
//  Created by Nguyen Tam Anh Bui on 1/29/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class Tapped: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func draw(_ rect: CGRect) {
        let randomNumber = arc4random_uniform(2)
        let path = makeRandomPath(shapeNumber: Int(randomNumber))
        path.stroke()
        path.fill()
        
    }
    
    // MARK : private methods

    private func chooseColor() {
    
        let randomColorNumber: Int = Int(arc4random_uniform(6))
        switch randomColorNumber {
        case 0:
            UIColor.red.set()
        case 1:
            UIColor.blue.set()
        case 2:
            UIColor.black.set()
        case 3:
            UIColor.cyan.set()
        case 4:
            UIColor.darkGray.set()
        default:
            UIColor.brown.set()
        }
    }
    
    // MARK : shape path maker functions
    
    private func basicCircle() -> UIBezierPath {
        let circleRadius = min(bounds.size.width, bounds.size.height) / 2.3
        let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        return (path)
    }
    
    private func basicSquare() -> UIBezierPath {
        let framesize: CGFloat = 50
        let squareSize = CGRect(x: bounds.midX - framesize / 2 ,y: bounds.midY - framesize / 2 ,width: framesize ,height: framesize)
        let path = UIBezierPath(rect: squareSize)
        return path
    }
    

    private func makeRandomPath(shapeNumber: Int) -> UIBezierPath {
             var path: UIBezierPath
        switch shapeNumber {
        case 0:
            path = basicCircle()
        case 1:
            path = basicSquare()
        default:
             path = basicCircle()
        }
        chooseColor()
        return path
    }
    
    
}
