//
//  Utility.swift
//  MaterialShowcase
//
//  Created by Andrei Tulai on 2017-11-16.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
  
  /// Returns color from its hex string
  ///
  /// - Parameter hexString: the color hex string
  /// - Returns: UIColor
  public static func fromHex(hexString: String) -> UIColor {
    let hex = hexString.trimmingCharacters(
      in: CharacterSet.alphanumerics.inverted)
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    let a, r, g, b: UInt32
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      return UIColor.clear
    }
    
    return UIColor(
      red: CGFloat(r) / 255,
      green: CGFloat(g) / 255,
      blue: CGFloat(b) / 255,
      alpha: CGFloat(a) / 255)
  }
}

extension UIView {
  
  // Transform a view's shape into circle
  func asCircle() {
    self.layer.cornerRadius = self.frame.width / 2;
    self.layer.masksToBounds = true
  }
  
  func setTintColor(_ color: UIColor, recursive: Bool) {
    tintColor = color
    if recursive {
      subviews.forEach({$0.setTintColor(color, recursive: true)})
    }
  }
}

extension UILabel {
  func sizeToFitHeight() {
    let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
    tempLabel.numberOfLines = numberOfLines
    tempLabel.lineBreakMode = lineBreakMode
    tempLabel.font = font
    tempLabel.text = text
    tempLabel.sizeToFit()
    frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: tempLabel.frame.height)
  }
}

extension UIView
{
  func copyView<T: UIView>() -> T {
    return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
  }
  func addHeight(_ height: CGFloat) {
    self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: self.frame.height + height))
  }
}

extension UIViewKeyframeAnimationOptions {
  
  static var curveEaseIn: UIViewKeyframeAnimationOptions {
    get {
      return UIViewKeyframeAnimationOptions(animationOptions: .curveEaseIn)
    }
  }
  
  static var curveEaseOut: UIViewKeyframeAnimationOptions {
    get {
      return UIViewKeyframeAnimationOptions(animationOptions: .curveEaseOut)
    }
  }
  
  static var curveEaseInOut: UIViewKeyframeAnimationOptions {
    get {
      return UIViewKeyframeAnimationOptions(animationOptions: .curveEaseInOut)
    }
  }
  
  static var curveLinear: UIViewKeyframeAnimationOptions {
    get {
      return UIViewKeyframeAnimationOptions(animationOptions: .curveLinear)
    }
  }
  
  init(animationOptions: UIViewAnimationOptions) {
    self.init(rawValue: animationOptions.rawValue)
  }
}

extension CGRect {
  var center: CGPoint {
    get {
      return CGPoint(x: midX, y: midY)
    }
  }
}
