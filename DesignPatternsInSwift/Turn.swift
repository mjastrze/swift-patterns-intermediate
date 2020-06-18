//
//  Turn.swift
//  DesignPatternsInSwift
//
//  Created by Maciej Jastrzębski on 6/18/20.
//  Copyright © 2020 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class Turn {
  // 1
  let shapes: [Shape]
  var matched: Bool?

  init(shapes: [Shape]) {
    self.shapes = shapes
  }

  // 2
  func turnCompletedWithTappedShape(tappedShape: Shape) {
    let maxArea = shapes.reduce(0) { $0 > $1.area ? $0 : $1.area }
    matched = tappedShape.area >= maxArea
  }
}
