//
//  TimeLine.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/11.
//

import SwiftUI

let timeLineSubItemWidth: CGFloat = 40

struct TimeLineView: UIViewRepresentable {
  let timeRanges: [TimeRange]
  
  func makeUIView(context: Context) -> TimeLineShap {
    let timeline = TimeLineShap()
    timeline.timeRanges = timeRanges
    timeline.backgroundColor = .clear
    timeline.frame = CGRect(x: 0, y: 0, width: 48 * timeLineSubItemWidth + 2 + 2, height: 60)
    return timeline
  }
  
  func updateUIView(_ uiView: TimeLineShap, context: Context) {
    
  }
}

class TimeLineShap: UIView {
  var timeRanges: [TimeRange] = [] {
    didSet { updateSelectionViewLayout() }
  }
  
  override var intrinsicContentSize: CGSize {
    CGSize(width: 48 * timeLineSubItemWidth + 2 + 2, height: 60)
  }
  
  private let height: CGFloat = 40 + 16
  private let originalX: CGFloat = 2
  private var primaryColor: UIColor {
    traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
  }
  
  private lazy var selectionView: TimeSelectionView = {
    let height = self.height - 16
    let view = TimeSelectionView(frame: CGRect(x: 0, y: self.height - height, width: timeLineSubItemWidth * 2, height: height))
    view.backgroundColor = .green.withAlphaComponent(0.7)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func updateSelectionViewLayout() {
    if subviews.firstIndex(of: selectionView) == nil {
      let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(sender:)))
      selectionView.addGestureRecognizer(pan)
      addSubview(selectionView)
    }
    selectionView.timeRange = (0, 2)
  }
  
  override func draw(_ rect: CGRect) {
    let path = UIBezierPath()
    
    for i in 0...48 {
      path.move(to: CGPoint(x: CGFloat(i) * timeLineSubItemWidth + originalX, y: i % 2 == 0 ? 0 : 24))
      path.addLine(to: CGPoint(x: CGFloat(i) * timeLineSubItemWidth + originalX, y: height))
    }
    path.move(to: CGPoint(x: originalX, y: height))
    path.addLine(to: CGPoint(x: 48 * timeLineSubItemWidth + originalX, y: height))
    
    let attr: [NSAttributedString.Key: Any] = [
      .font : UIFont.systemFont(ofSize: 10, weight: .thin),
      .foregroundColor: primaryColor,
    ]
    
    // draw time label
    for i in 0...23 {
      let rect = CGRect(x: CGFloat(i) * timeLineSubItemWidth * 2 + 8, y: 0, width: 50, height: 14)
      NSString(format: "%02d:00", i).draw(
        in: rect,
        withAttributes: attr)
    }
    path.lineWidth = 0.5
    primaryColor.withAlphaComponent(0.8).setStroke()
    path.stroke()
    
    timeRanges.forEach {
      let subPath = self.subPath(start: $0.start, count: $0.end - $0.start)
      path.append(subPath)
    }
  }
  
  private func subPath(start: Int, count: Int) -> UIBezierPath {
    let subWidth = CGFloat(count) * timeLineSubItemWidth
    let maxX = CGFloat(start) * timeLineSubItemWidth + subWidth
    var x = CGFloat(start) * timeLineSubItemWidth + 2
    let subHeight = self.height - 24 - 10
    
    let filledPath = UIBezierPath(rect: CGRect(x: x + originalX, y: subHeight, width: subWidth, height: 23.5))
    UIColor.systemBackground.setFill()
    filledPath.fill()
    
    let subPath = UIBezierPath()
    while x <= maxX {
      subPath.move(to: CGPoint(x: x + originalX, y: subHeight))
      subPath.addLine(to: CGPoint(x: x + originalX, y: height-0.5))
      x += 2
    }
    primaryColor.setStroke()
    subPath.lineWidth = 0.5
    subPath.stroke()
    filledPath.append(subPath)
    return filledPath
  }
  
  @objc private func panGestureHandler(sender: UIPanGestureRecognizer) {
    let location = sender.location(in: self)
    let x = location.x - selectionView.bounds.width / 2
    switch sender.state {
    case .changed:
      updateX(x)
    case .ended:
      // 四舍五入
      let startIndex = Int(CGFloat(x - 2) / timeLineSubItemWidth + 0.5)
      selectionView.timeRange = (Int(startIndex), selectionView.timeRange.end)
    default:
      break
    }
  }
  
  private func updateX(_ x: CGFloat) {
    if x < originalX { return }
    selectionView.frame = CGRect(x: x,
                                 y: selectionView.frame.origin.y,
                                 width: selectionView.bounds.width,
                                 height: selectionView.bounds.height)
  }
  
}


class TimeSelectionView: UIView {
  private var selectedStartIndex = 0
  private var selectedEndIndex = 2
  
  private var panView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.red
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  var timeRange: TimeRange = (0, 2) {
    didSet { updateFrame() }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateFrame() {
    let x = CGFloat(timeRange.start) * timeLineSubItemWidth + 2
    let width = max(CGFloat(timeRange.end - timeRange.start) * timeLineSubItemWidth, frame.width)
    frame = CGRect(x: x,
                   y: frame.origin.y,
                   width: width,
                   height: bounds.height)
  }
  
  private var width: CGFloat = 0
  @objc private func panGestureHandler(sender: UIPanGestureRecognizer) {
    let trans = sender.translation(in: self)
    switch sender.state {
    case .began:
      width = bounds.width
    case .changed:
      updateWidth(width + trans.x)
    case .ended:
      let value = CGFloat(Int(frame.width) % Int(timeLineSubItemWidth)) / timeLineSubItemWidth
      let finalWidth = value > 0.5 ? (1 - value) * timeLineSubItemWidth : -value * timeLineSubItemWidth
      updateWidth(frame.width + finalWidth)
    default:
      break
    }
  }
  
  private func updateWidth(_ width: CGFloat) {
    if width < timeLineSubItemWidth * 2 { return }
    self.frame = CGRect(x: frame.origin.x,
                        y: frame.origin.y,
                        width: width,
                        height: bounds.height)
  }
  
  private func setupView() {
    let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(sender:)))
    panView.addGestureRecognizer(pan)
    addSubview(panView)
    panView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    panView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    panView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    panView.widthAnchor.constraint(equalToConstant: 8).isActive = true
  }
}
