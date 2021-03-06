//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallPulseSync: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 0.6
  private var size: CGSize = .zero
  private var circleSize: CGFloat = 0

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSpacing: CGFloat = 2
    self.size = size
    circleSize = (size.width - circleSpacing * 2) / 3
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - circleSize) / 2
    let beginTime = CACurrentMediaTime()
    let beginTimes: [CFTimeInterval] = [0.07, 0.14, 0.21]
    let animation = self.animation
    
    // Draw circles
    for i in 0 ..< 3 {
      let circle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
      let frame = CGRect(x: x + circleSize * CGFloat(i) + circleSpacing * CGFloat(i),
                         y: y,
                         width: circleSize,
                         height: circleSize)

      animation.beginTime = beginTime + beginTimes[i]
      circle.frame = frame
      circle.addAnimation(animation, forKey: "animation")
      layer.addSublayer(circle)
    }

  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallPulseSync {

  var animation: CAKeyframeAnimation {
    let deltaY = (size.height / 2 - circleSize / 2) / 2
    let timingFunciton = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
    animation.keyTimes = [0, 0.33, 0.66, 1]
    animation.timingFunctions = [timingFunciton, timingFunciton, timingFunciton]
    animation.values = [0, deltaY, -deltaY, 0]
    animation.duration = duration
    animation.repeatCount = HUGE
    animation.removedOnCompletion = false
    return animation
  }

}
