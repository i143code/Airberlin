//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by Ashish Ranjan
//

import UIKit
import QuartzCore

@IBDesignable
class AvatarView: UIView {
  
  //constants
  let lineWidth: CGFloat = 6.0
  let animationDuration = 1.0
  
  //ui
  let photoLayer = CALayer()
  let circleLayer = CAShapeLayer()
  let maskLayer = CAShapeLayer()
  let label: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
    label.textAlignment = .Center
    label.textColor = UIColor.blackColor()
    return label
  }()
  
  //variables
  @IBInspectable
  var image: UIImage! {
    didSet {
    photoLayer.contents = image.CGImage
    }
  }
  
  @IBInspectable
  var name: String? {
    didSet {
    label.text = name
    }
  }
  
  var keepAnimating = true
  
  override func didMoveToWindow() {
    layer.addSublayer(photoLayer)
    photoLayer.mask = maskLayer
    layer.addSublayer(circleLayer)
    addSubview(label)
  }
  
  override func layoutSubviews() {
    
    //Size the avatar image to fit
    photoLayer.frame = CGRect(
      x: (bounds.size.width - image.size.width + lineWidth)/2,
      y: (bounds.size.height - image.size.height - lineWidth)/2,
      width: image.size.width,
      height: image.size.height)
    
    //Draw the circle
    circleLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
    circleLayer.strokeColor = UIColor.whiteColor().CGColor
    circleLayer.lineWidth = lineWidth
    circleLayer.fillColor = UIColor.clearColor().CGColor
    
    //Size the layer
    maskLayer.path = circleLayer.path
    maskLayer.position = CGPoint(x: 0.0, y: 10.0)
    
    //Size the label
    label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
  }
  
  func bounceOffPoint(bouncePoint: CGPoint, morphSize: CGSize) {
    let originalCenter = center
    
    UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
      self.center = bouncePoint
      }, completion: {_ in
        //complete bounce
        
    })
    
    UIView.animateWithDuration(animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: {
      self.center = originalCenter
      }, completion: {_ in
        delay(seconds: 0.1) {
          if self.keepAnimating {
            self.bounceOffPoint(bouncePoint, morphSize: morphSize)
          }
        }
    })
    
    var morphRect = CGRect(x: 0.0, y: bounds.size.height - morphSize.height,
                                   width: morphSize.width, height: morphSize.height)
    
    if originalCenter.x < bouncePoint.x {
      morphRect.origin.x = bounds.width - morphSize.width
    }
    
    let morph = CABasicAnimation(keyPath: "path")
    morph.duration = animationDuration
    morph.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    morph.toValue = UIBezierPath(ovalInRect: morphRect).CGPath
    
    circleLayer.addAnimation(morph, forKey: nil)
    maskLayer.addAnimation(morph, forKey: nil)
  }
}
