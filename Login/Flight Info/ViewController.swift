
//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by Ashish Ranjan
//
import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var bgImageView: UIImageView!
  
  @IBOutlet var summary: UILabel!
  
  @IBOutlet var flightNr: UILabel!
  @IBOutlet var gateNr: UILabel!
  @IBOutlet var departingFrom: UILabel!
  @IBOutlet var arrivingTo: UILabel!
  @IBOutlet var planeImage: UIImageView!
  
  @IBOutlet var flightStatus: UILabel!
  @IBOutlet var statusBanner: UIImageView!
  
  var snowView: SnowView!
  
  //MARK: view controller methods
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    //set the initial flight data
    self.changeFlightDataTo(londonToParis)
  }
  
  func changeFlightDataTo(data: FlightData) {
    
    //populate the UI with the next flight's data
    summary.text = data.summary
    flightNr.text = data.flightNr
    gateNr.text = data.gateNr
    departingFrom.text = data.departingFrom
    arrivingTo.text = data.arrivingTo
    flightStatus.text = data.flightStatus

    UIView.transitionWithView(snowView, duration: 1.5, options: [.TransitionCrossDissolve], animations: {
      self.snowView.hidden = !data.showWeatherEffects
      }, completion: nil)

    //duplicate background image
    let overlay = duplicateImageViewFrom(bgImageView, newImageName: data.weatherImageName)
    
    overlay.alpha = 0.0
    overlay.transform = CGAffineTransformMakeScale(1.33, 1.0)
    
    bgImageView.superview!.insertSubview(overlay, aboveSubview: bgImageView)
    
    //duplicate departing airpot
    let helperLabel = duplicateLabelFrom(departingFrom)
    departingFrom.superview!.addSubview(helperLabel)
    
    let departingOffset = CGFloat(-80)
    
    departingFrom.center.x += departingOffset
    departingFrom.alpha = 0
    departingFrom.text = data.departingFrom
    
    //kick off animations
    UIView.animateWithDuration(0.5, animations: {
      overlay.alpha = 1.0
      overlay.transform = CGAffineTransformIdentity
      
      self.departingFrom.center.x -= departingOffset
      self.departingFrom.alpha = 1.0
      
      helperLabel.alpha = 0.0
      helperLabel.center.x += departingOffset
      
    }, completion: {_ in
      self.bgImageView.image = overlay.image
      overlay.removeFromSuperview()
      
      helperLabel.removeFromSuperview()
    })
    
    // schedule next flight
    delay(seconds: 3.0) {
      self.changeFlightDataTo(data.isTakingOff ? parisToRome : londonToParis)
    }
    
  }
}

////////////////////////////////////////
//
//    Starter project code
//
////////////////////////////////////////
extension ViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //add the snow effect layer
    snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
    let snowClipView = UIView(frame: CGRectOffset(view.frame, 0, 50))
    snowClipView.clipsToBounds = true
    snowClipView.addSubview(snowView)
    view.addSubview(snowClipView)
  }
  
  func duplicateImageViewFrom(originalView: UIImageView, newImageName: String) -> UIImageView {
    let duplicate = UIImageView(image: UIImage(named: newImageName)!)
    duplicate.frame = bgImageView.frame
    duplicate.contentMode = bgImageView.contentMode
    duplicate.center = bgImageView.center
    return duplicate
  }
  
  func duplicateLabelFrom(originalLabel: UILabel, newText: String? = nil) -> UILabel {
    let duplicate = UILabel(frame: originalLabel.frame)
    duplicate.text = newText ?? originalLabel.text
    duplicate.font = originalLabel.font
    duplicate.textAlignment = originalLabel.textAlignment
    duplicate.textColor = originalLabel.textColor
    duplicate.backgroundColor = UIColor.clearColor()
    return duplicate
  }
  
}
