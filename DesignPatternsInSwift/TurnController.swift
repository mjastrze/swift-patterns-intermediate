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

  init(turnStrategy: TurnStrategy) {
    self.turnStrategy = turnStrategy
    self.scorer = MatchScorer()
    self.scorer.nextScorer = StreakScorer()
  }

  // 3
  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapeViews = turnStrategy.makeShapeViewsForNextTurnGivenPastTurns(pastTurns: pastTurns)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }

  // 4
  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn!.turnCompletedWithTappedShape(tappedShape: tappedShape)
    pastTurns.append(currentTurn!)

    let scoreIncrement = scorer.computeScoreIncrement(pastTurnsReversed: pastTurns.reversed())
    return scoreIncrement
  }

  private let turnStrategy: TurnStrategy
  private var scorer: Scorer
}
