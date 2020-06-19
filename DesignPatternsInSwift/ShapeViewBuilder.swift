//
//  ShapeViewBuilder.swift
//  DesignPatternsInSwift
//
//  Created by Maciej Jastrzębski on 6/18/20.
//  Copyright © 2020 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

class ShapeViewBuilder {
  // 1
  var showFill  = true
  var fillColor = UIColor.orange

  // 2
  var showOutline  = true
  var outlineColor = UIColor.gray

  // 3
  init(shapeViewFactory: ShapeViewFactory) {
    self.shapeViewFactory = shapeViewFactory
  }

  // 4
  func buildShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    let shapeViews = shapeViewFactory.makeShapeViewsForShapes(shapes: shapes)
    configureShapeView(shapeView: shapeViews.0)
    configureShapeView(shapeView: shapeViews.1)
    return shapeViews
  }

  // 5
  private func configureShapeView(shapeView: ShapeView) {
    shapeView.showFill  = showFill
    shapeView.fillColor = fillColor
    shapeView.showOutline  = showOutline
    shapeView.outlineColor = outlineColor
  }

  private var shapeViewFactory: ShapeViewFactory
}
