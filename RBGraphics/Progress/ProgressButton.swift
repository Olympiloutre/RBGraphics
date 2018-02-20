//
//  ProgressButton.swift
//
//  Created by Romuald Brochard on 19/02/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//

import Foundation

import UIKit

/**
 Enumeration of different states the ProgressButton can take
 - .start - Arrow
 - .progress - Progression circle
 - .done - Validation sigil
 */
public enum ProgressButtonState {
    case start
    case progress
    case done
}


@IBDesignable
class ProgressButton : UIView {
    
    /** Color */
    @IBInspectable var color: UIColor = UIColor.gray{
        didSet {
            self.setNeedsDisplay()
        }
    }

    /** border size */
    @IBInspectable var border: CGFloat = 2.0{
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /**
     Current item state.
     When set ProgressButton will redraw automatically
     */
    var state: ProgressButtonState = .start {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /** Progress percent ( for .progress purposes )  */
    var percent: CGFloat = 0.0 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /** Closure action to be performed when download state is tapped */
    var downloadAction: () -> Void = {}
    
    /**
     Side of the square that can fit into the uiview ( to fit every further drawing )
     Basically the min between height and width
     */
    private var side: CGFloat {
        get {
            return ( self.frame.size.width > self.frame.size.height ? self.frame.size.height : self.frame.size.width  )
        }
    }
    
    /** Padding inside the view */
    private var padding: CGFloat {
        get {
            return side/10
        }
    }
    
    /**
     Bezier Path to draw forms
     */
    private var path: UIBezierPath!
    
    
    
    // MARK:- Init & IB
    
    /**
     Overriding UIView init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /**
     Overriding IB display
     */
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setNeedsDisplay()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsDisplay()
    }
    
    
    // MARK:- Func
    /**
     Setup
     - Add gesture recognizer to UIVIew
     */
    fileprivate func setup(){
        let tapgesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapaction (_:)))
        self.addGestureRecognizer(tapgesture)
    }
    
    /**
     UITapGEsture Action based on state
     - on start, perform downloadAction() closure
     */
    @objc func tapaction(_ sender:UITapGestureRecognizer){
        if( self.state == .start ){
            self.downloadAction()
        }
    }
    
    // MARK:- Draw
    /**
     Overriding draw method to be computed each time view need to get displayed again
     Mandatory to use UIBezierPath
     */
    override func draw(_ rect: CGRect) {
        
        switch state {
            case .start: drawArrow()
            case .progress: drawProgress()
            case .done: drawDone()
        }
        
    }
    /** Draw an arrow pointing down */
    fileprivate func drawArrow(){
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: self.frame.size.width/2, y: (self.frame.size.height - side)/2 + padding))
        path.addLine(to: CGPoint(x: self.frame.size.width/2, y: (self.frame.size.height + side - border)/2 - padding))
        path.move(to: CGPoint(x: (self.frame.size.width + side - border)/2 - padding, y: (self.frame.size.height )/2))
        path.addLine(to: CGPoint(x: (self.frame.size.width)/2, y: (self.frame.size.height + side - border)/2 - padding))
        path.addLine(to: CGPoint(x: (self.frame.size.width - side + border)/2 + padding, y: (self.frame.size.height )/2 ))

        path.lineWidth = border
        color.setStroke()
        path.stroke()
    }
    
    /** draw an arc based on progress */
    fileprivate func drawProgress(){
        path = UIBezierPath()

        path.addArc(withCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 ),
                    radius: (side - border)/2 - padding,
                    startAngle: (CGFloat.pi * 3/2),
                    endAngle: (CGFloat.pi * 2) * percent + (CGFloat.pi * 3/2) ,
                    clockwise: true)
        
        path.lineWidth = border
        color.setStroke()
        path.stroke()
        
    }
    
    /** draw a circle and a validate symbol */
    fileprivate func drawDone(){
        path = UIBezierPath()
        
        path.addArc(withCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 ),
                    radius: (side - border)/2 - padding,
                    startAngle: (CGFloat.pi * 3/2),
                    endAngle: (CGFloat.pi * 7/2) ,
                    clockwise: true)
        
        let treshold = side / 20
        path.move(to: CGPoint(x: (self.frame.size.width - side )/2 + side/3  + padding/2 - treshold, y: (self.frame.size.height)/2 - padding/2 + treshold))
        path.addLine(to: CGPoint(x: self.frame.size.width/2 - treshold, y: (self.frame.size.height - side)/2 + side*2/3 - padding + treshold))
        path.addLine(to: CGPoint(x: (self.frame.size.width - side)/2 + side*5/6 - padding - treshold, y: (self.frame.size.height - side)/2 + side/3 + treshold))
        
        path.lineWidth = border
        color.setStroke()
        path.stroke()
    }
    
    
}
