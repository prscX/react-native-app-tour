//
//  MaterialShowcaseInstructionView.swift
//  MaterialShowcase
//
//  Created by Andrei Tulai on 2017-11-16.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import UIKit

public class MaterialShowcaseInstructionView: UIView {
  
  internal static let PRIMARY_TEXT_SIZE: CGFloat = 20
  internal static let SECONDARY_TEXT_SIZE: CGFloat = 15
  internal static let PRIMARY_TEXT_COLOR = UIColor.white
  internal static let SECONDARY_TEXT_COLOR = UIColor.white.withAlphaComponent(0.87)
  internal static let PRIMARY_DEFAULT_TEXT = "Awesome action"
  internal static let SECONDARY_DEFAULT_TEXT = "Tap here to do some awesome thing"
  
  public var primaryLabel: UILabel!
  public var secondaryLabel: UILabel!
  
  // Text
  public var primaryText: String!
  public var secondaryText: String!
  public var primaryTextColor: UIColor!
  public var secondaryTextColor: UIColor!
  public var primaryTextSize: CGFloat!
  public var secondaryTextSize: CGFloat!
  public var primaryTextFont: UIFont?
  public var secondaryTextFont: UIFont?
  public var primaryTextAlignment: NSTextAlignment!
  public var secondaryTextAlignment: NSTextAlignment!
  
  public init() {
    // Create frame
    let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
    super.init(frame: frame)
    
    configure()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Initializes default view properties
  fileprivate func configure() {
    setDefaultProperties()
  }
  
  fileprivate func setDefaultProperties() {
    // Text
    primaryText = MaterialShowcaseInstructionView.PRIMARY_DEFAULT_TEXT
    secondaryText = MaterialShowcaseInstructionView.SECONDARY_DEFAULT_TEXT
    primaryTextColor = MaterialShowcaseInstructionView.PRIMARY_TEXT_COLOR
    secondaryTextColor = MaterialShowcaseInstructionView.SECONDARY_TEXT_COLOR
    primaryTextSize = MaterialShowcaseInstructionView.PRIMARY_TEXT_SIZE
    secondaryTextSize = MaterialShowcaseInstructionView.SECONDARY_TEXT_SIZE
  }
  
  /// Configures and adds primary label view
  private func addPrimaryLabel() {
    primaryLabel = UILabel()
    
    if let font = primaryTextFont {
      primaryLabel.font = font
    } else {
      primaryLabel.font = UIFont.boldSystemFont(ofSize: primaryTextSize)
    }
    primaryLabel.textColor = primaryTextColor
    primaryLabel.textAlignment = self.primaryTextAlignment ?? .left
    primaryLabel.numberOfLines = 0
    primaryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    primaryLabel.text = primaryText
    
    //    // Calculate x position
    //    let xPosition = backgroundView.frame.minX > 0 ?
    //      backgroundView.frame.minX + LABEL_MARGIN : LABEL_MARGIN
    //
    //    // Calculate y position
    //    var yPosition: CGFloat!
    //
    //    if getTargetPosition(target: targetView, container: containerView) == .above {
    //      yPosition = center.y + TEXT_CENTER_OFFSET
    //    } else {
    //      yPosition = center.y - TEXT_CENTER_OFFSET - LABEL_DEFAULT_HEIGHT * 2
    //    }
    
    primaryLabel.frame = CGRect(x: 0,
                                y: 0,
                                width: getWidth(),
                                height: 0)
    primaryLabel.sizeToFitHeight()
    addSubview(primaryLabel)
  }
  
  /// Configures and adds secondary label view
  private func addSecondaryLabel() {
    secondaryLabel = UILabel()
    if let font = secondaryTextFont {
      secondaryLabel.font = font
    } else {
      secondaryLabel.font = UIFont.systemFont(ofSize: secondaryTextSize)
    }
    secondaryLabel.textColor = secondaryTextColor
    secondaryLabel.textAlignment = self.secondaryTextAlignment ?? .left
    secondaryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    secondaryLabel.text = secondaryText
    secondaryLabel.numberOfLines = 3
    
    secondaryLabel.frame = CGRect(x: 0,
                                  y: primaryLabel.frame.height,
                                  width: getWidth(),
                                  height: 0)
    secondaryLabel.sizeToFitHeight()
    addSubview(secondaryLabel)
    frame = CGRect(x: frame.minX, y: frame.minY, width: getWidth(), height: primaryLabel.frame.height + secondaryLabel.frame.height)
  }
  
  //Calculate width per device
  private func getWidth() -> CGFloat{
    //superview was left side
    if (self.superview?.frame.origin.x)! < CGFloat(0) {
        return frame.width - (frame.minX/2)
    } else if ((self.superview?.frame.origin.x)! + (self.superview?.frame.size.width)! >
        UIScreen.main.bounds.width) { //superview was right side
        return (frame.width - frame.minX)/2
    }
    return (frame.width - frame.minX)
  }
    
  /// Overrides this to add subviews. They will be drawn when calling show()
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    addPrimaryLabel()
    addSecondaryLabel()
    
    subviews.forEach({$0.isUserInteractionEnabled = false})
  }
}
