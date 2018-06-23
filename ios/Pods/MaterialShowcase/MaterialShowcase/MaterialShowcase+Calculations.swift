//
//  MaterialShowcase+Calculations.swift
//  MaterialShowcase
//
//  Created by Andrei Tulai on 2017-11-16.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import UIKit

extension MaterialShowcase {

  func isInGutter(center: CGPoint) -> Bool {
    return center.y < offsetThreshold || containerView.frame.height - center.y < offsetThreshold
  }
  
  func getOuterCircleCenterPoint(for target: UIView) -> CGPoint {
    if isInGutter(center: target.center) {
      return target.center
    }
    
    let targetRadius = max(target.frame.width, target.frame.height) / 2 + TARGET_PADDING
    let totalTextHeight = instructionView.frame.height
    
    let onTop = getTargetPosition(target: targetView, container: containerView) == .below
    
    let left = min(instructionView.frame.minX, target.frame.minX - targetRadius)
    let right = max(instructionView.frame.maxX, target.frame.maxX + targetRadius)
    let titleHeight = instructionView.primaryLabel.frame.height
    let centerY = onTop ? target.center.y - TARGET_HOLDER_RADIUS - TARGET_PADDING - totalTextHeight + titleHeight
      : target.center.y + TARGET_HOLDER_RADIUS + TARGET_PADDING + titleHeight
    
    return CGPoint(x: (left + right) / 2, y: centerY)
  }
  
  func getOuterCircleRadius(center: CGPoint, textBounds: CGRect, targetBounds: CGRect) -> CGFloat {
    let targetCenterX = targetBounds.midX
    let targetCenterY = targetBounds.midY
    
    let expandedRadius = 1.1 * TARGET_HOLDER_RADIUS
    let expandedBounds = CGRect(x: targetCenterX, y: targetCenterY, width: 0, height: 0)
    expandedBounds.insetBy(dx: -expandedRadius, dy: -expandedRadius);
    
    let textRadius = maxDistance(from: center, to: textBounds)
    let targetRadius = maxDistance(from: center, to: expandedBounds)
    return max(textRadius, targetRadius) + 40
  }
  
  func maxDistance(from point: CGPoint, to rect: CGRect) -> CGFloat {
    let tl = distance(point, CGPoint(x: rect.minX, y: rect.minY))
    let tr = distance(point, CGPoint(x: rect.maxX, y: rect.minY))
    let bl = distance(point, CGPoint(x: rect.minX, y: rect.maxY))
    let br = distance(point, CGPoint(x: rect.maxX, y: rect.maxY))
    return max(tl, max(tr, max(bl, br)))
  }
  
  func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    let xDist = a.x - b.x
    let yDist = a.y - b.y
    return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
  }
}
