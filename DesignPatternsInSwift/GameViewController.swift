//
//  GameViewController.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 1 ***** ADDITION
    shapeViewFactory = SquareShapeViewFactory(size: gameView.sizeAvailableForShapes())
    shapeFactory = SquareShapeFactory(minProportion: 0.3, maxProportion: 0.8)
//    shapeViewFactory = CircleShapeViewFactory(size: gameView.sizeAvailableForShapes())
//    shapeFactory = CircleShapeFactory(minProportion: 0.3, maxProportion: 0.8)
    shapeViewBuilder = ShapeViewBuilder(shapeViewFactory: shapeViewFactory)
    shapeViewBuilder.fillColor = UIColor.brown
    shapeViewBuilder.outlineColor = UIColor.orange
    turnController = TurnController(shapeFactory: shapeFactory, shapeViewBuilder: shapeViewBuilder)
    
    beginNextTurn()
  }

  override var prefersStatusBarHidden: Bool {
    get {
      return true
    }
  }

  private func beginNextTurn() {
    let shapeViews = turnController.beginNewTurn()

    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += self.turnController.endTurnWithTappedShape(tappedShape: tappedView.shape)
      self.beginNextTurn()
    }
    shapeViews.1.tapHandler = shapeViews.0.tapHandler

    gameView.addShapeViews(newShapeViews: shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
  
  private var shapeViewFactory: ShapeViewFactory!
  
  private var shapeFactory: ShapeFactory!
  
  private var shapeViewBuilder: ShapeViewBuilder!
  
  private var turnController: TurnController!
}
