//
//  TimeLine.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/11.
//

import SwiftUI

struct TimeLineView: UIViewRepresentable {
  
  func makeUIView(context: Context) -> TimeLineShap {
    let timeline = TimeLineShap()
    timeline.backgroundColor = .clear
    timeline.frame = CGRect(x: 0, y: 0, width: 48 * 20 + 2 + 14, height: 60)
    return timeline
  }
  
  func updateUIView(_ uiView: TimeLineShap, context: Context) {
    
  }
}

class TimeLineShap: UIView {
  
  override var intrinsicContentSize: CGSize {
    CGSize(width: 48 * 20 + 2 + 14, height: 60)
  }
  
  private let height: Double = 40 + 16
  private let originalX: Double = 2
  private var primaryColor: UIColor {
    traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
  }
  
  override func draw(_ rect: CGRect) {
    let path = UIBezierPath()
    
    for i in 0...48 {
      path.move(to: CGPoint(x: Double(i) * 20 + originalX, y: i % 2 == 0 ? 16 : 24))
      path.addLine(to: CGPoint(x: Double(i) * 20 + originalX, y: height))
    }
    path.move(to: CGPoint(x: originalX, y: 40 + 16))
    path.addLine(to: CGPoint(x: 48 * 20 + originalX, y: height))
    
    let attr: [NSAttributedString.Key: Any] = [
      .font : UIFont.systemFont(ofSize: 10, weight: .thin),
      .foregroundColor: primaryColor,
    ]
    
    for i in 1...11 {
      let rect = CGRect(x: Double(i) * 80 - 12, y: 0, width: 50, height: 14)
      NSString(string: "\(i*2):00").draw(
        in: rect,
        withAttributes: attr)
    }
    path.lineWidth = 0.5
    primaryColor.withAlphaComponent(0.8).setStroke()
    path.stroke()
    
    [0, 9].forEach {
      let subPath = self.subPath(start: $0, count: 3)
      path.append(subPath)
    }
  }
  
  private func subPath(start: Int, count: Int) -> UIBezierPath {
    let subWidth: Double = Double(20 * count)
    let maxX = Double(start * 20) + subWidth
    var x: Double = Double(start * 20) + 2
    
    let filledPath = UIBezierPath(rect: CGRect(x: x + originalX, y: height - 24, width: subWidth, height: 23.5))
    UIColor.systemBackground.setFill()
    filledPath.fill()
    
    let subPath = UIBezierPath()
    while x <= maxX {
      subPath.move(to: CGPoint(x: x + originalX, y: height - 24))
      subPath.addLine(to: CGPoint(x: x + originalX, y: height-0.5))
      x += 2
    }
    primaryColor.setStroke()
    subPath.lineWidth = 0.5
    subPath.stroke()
    filledPath.append(subPath)
    return filledPath
  }
  
}
