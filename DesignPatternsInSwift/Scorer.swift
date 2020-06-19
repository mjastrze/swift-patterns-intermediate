//
//  Scorer.swift
//  DesignPatternsInSwift
//
//  Created by Maciej Jastrzębski on 6/18/20.
//  Copyright © 2020 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

// 1
protocol Scorer {
  func computeScoreIncrement<S: Sequence>(pastTurnsReversed: S) -> Int where Turn == S.Iterator.Element
  var nextScorer: Scorer? { get set }
}

// 2
class MatchScorer: Scorer {
  var nextScorer: Scorer? = nil
  
  func computeScoreIncrement<S : Sequence>(pastTurnsReversed: S) -> Int where Turn == S.Iterator.Element {
    var scoreIncrement: Int?
    // 3
    for turn in pastTurnsReversed {
      if scoreIncrement == nil {
        // 4
        scoreIncrement = turn.matched! ? 1 : -1
        break
      }
    }

    return (scoreIncrement ?? 0) + (nextScorer?.computeScoreIncrement(pastTurnsReversed: pastTurnsReversed) ?? 0)
  }
}

class StreakScorer: Scorer {
  var nextScorer: Scorer? = nil

  func computeScoreIncrement<S : Sequence>(pastTurnsReversed: S) -> Int where Turn == S.Iterator.Element {
    // 1
    var streakLength = 0
    for turn in pastTurnsReversed {
      if turn.matched! {
        // 2
        streakLength += 1
      } else {
        // 3
        break
      }
    }

    // 4
    let streakBonus = streakLength >= 5 ? 10 : 0
    return streakBonus + (nextScorer?.computeScoreIncrement(pastTurnsReversed: pastTurnsReversed) ?? 0)
  }
}
