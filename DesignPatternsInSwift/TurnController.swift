//
//  TurnController.swift
//  DesignPatternsInSwift
//
//  Created by Maciej Jastrzębski on 6/18/20.
//  Copyright © 2020 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class TurnController {
  // 1
  var currentTurn: Turn?
  var pastTurns: [Turn] = [Turn]()

  // 2
  init(shapeFactory: ShapeFactory, shapeViewBuilder: ShapeViewBuilder) {
    self.shapeFactory = shapeFactory
    self.shapeViewBuilder = shapeViewBuilder
  }

  // 3
  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapes = shapeFactory.createShapes()
    let shapeViews = shapeViewBuilder.buildShapeViewsForShapes(shapes: shapes)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }

  // 4
  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn!.turnCompletedWithTappedShape(tappedShape: tappedShape)
    pastTurns.append(currentTurn!)

    let scoreIncrement = currentTurn!.matched! ? 1 : -1
    return scoreIncrement
  }

  private let shapeFactory: ShapeFactory
  private var shapeViewBuilder: ShapeViewBuilder
}
