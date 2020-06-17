//
//  ShapeViewFactory.swift
//  DesignPatternsInSwift
//
//  Created by Maciej Jastrzębski on 6/17/20.
//  Copyright © 2020 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

// 1
protocol ShapeViewFactory {
  // 2
  var size: CGSize { get set }
  // 3
  func makeShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView)
}

class SquareShapeViewFactory: ShapeViewFactory {
  var size: CGSize

  // 1
  init(size: CGSize) {
    self.size = size
  }

  func makeShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    // 2
    let squareShape1 = shapes.0 as! SquareShape
    let shapeView1 =
      SquareShapeView(frame: CGRect(x: 0,
                                    y: 0,
                                    width: squareShape1.sideLength * size.width,
                                    height: squareShape1.sideLength * size.height))
    shapeView1.shape = squareShape1

    // 3
    let squareShape2 = shapes.1 as! SquareShape
    let shapeView2 =
      SquareShapeView(frame: CGRect(x: 0,
                                    y: 0,
                                    width: squareShape2.sideLength * size.width,
                                    height: squareShape2.sideLength * size.height))
    shapeView2.shape = squareShape2

    // 4
    return (shapeView1, shapeView2)
  }
}
