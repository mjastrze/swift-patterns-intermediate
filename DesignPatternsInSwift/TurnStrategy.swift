//
//  TurnStrategy.swift
//  DesignPatternsInSwift
//
//  Created by Maciej Jastrzębski on 6/18/20.
//  Copyright © 2020 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

// 1
protocol TurnStrategy {
  func makeShapeViewsForNextTurnGivenPastTurns(pastTurns: [Turn]) -> (ShapeView, ShapeView)
}

// 2
class BasicTurnStrategy: TurnStrategy {
  let shapeFactory: ShapeFactory
  let shapeViewBuilder: ShapeViewBuilder

  init(shapeFactory: ShapeFactory, shapeViewBuilder: ShapeViewBuilder) {
    self.shapeFactory = shapeFactory
    self.shapeViewBuilder = shapeViewBuilder
  }

  func makeShapeViewsForNextTurnGivenPastTurns(pastTurns: [Turn]) -> (ShapeView, ShapeView) {
    return shapeViewBuilder.buildShapeViewsForShapes(shapes: shapeFactory.createShapes())
  }
}

class RandomTurnStrategy: TurnStrategy {
  // 3
  let firstStrategy: TurnStrategy
  let secondStrategy: TurnStrategy

  init(firstStrategy: TurnStrategy, secondStrategy: TurnStrategy) {
    self.firstStrategy = firstStrategy
    self.secondStrategy = secondStrategy
  }

  // 4
  func makeShapeViewsForNextTurnGivenPastTurns(pastTurns: [Turn]) -> (ShapeView, ShapeView) {
    if Utils.randomBetweenLower(lower: 0.0, andUpper: 100.0) < 50.0 {
      return firstStrategy.makeShapeViewsForNextTurnGivenPastTurns(pastTurns: pastTurns)
    } else {
      return secondStrategy.makeShapeViewsForNextTurnGivenPastTurns(pastTurns: pastTurns)
    }
  }
}
