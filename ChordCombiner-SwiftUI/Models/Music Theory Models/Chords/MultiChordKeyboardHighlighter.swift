//
//  MultiChordKeyboardHighlighter.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI

//class MultiChordKeyboardHighlighter {
//  private static var sharedInstance: MultiChordKeyboardHighlighter?
//  
//  private init() { }
//  
//  public class func singleton() -> MultiChordKeyboardHighlighter {
//    if sharedInstance == nil {
//      sharedInstance = MultiChordKeyboardHighlighter()
//    }
//    return sharedInstance!
//  }
//  
//  func setAndHighlightChords(multiChord: MultiChord, oldMultiChord: MultiChord, isInitial: inout Bool, lowerKeyboard: inout Keyboard, upperKeyboard: inout Keyboard, combinedKeyboard: inout Keyboard, color: Color, secondColor: Color) {
//    let resultChordExists: Bool = multiChord.resultChord != nil ? true : false
//    var isSlashChord: Bool = false
//    
//    if let resultChordVoicingCalculator = multiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
//      isSlashChord = resultChordVoicingCalculator.isSlashChord == true ? true : false
//    }
//    
//    let lowerStackedPitches = multiChord.multiChordVoicingCalculator.lowerStackedPitches
//    let upperStackedPitches = multiChord.multiChordVoicingCalculator.upperStackedPitches
//    
//    let (lowerSplitPitches, upperSplitPitches) = multiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: lowerStackedPitches, upperPitches: upperStackedPitches)
//    
//    if isInitial {
//      lowerKeyboard.toggleHighlightKeysSingle(degreeNumbers: lowerStackedPitches, color: color)
//      upperKeyboard.toggleHighlightKeysSingle(degreeNumbers: upperStackedPitches, color: secondColor)
//      
//      multiChord.multiChordVoicingCalculator.setResultChordCombinedHighlightedPitches()
//      
//      combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//        onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//        onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//        commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//        lowerStackedPitches: lowerSplitPitches,
//        upperStackedPitches: upperSplitPitches,
//        resultChordExists: resultChordExists,
//        isSlashChord: isSlashChord,
//        color: color,
//        secondColor: secondColor)
//      isInitial = false
//    } else {
//      let oldResultChordExists: Bool = oldMultiChord.resultChord != nil ? true : false
//      var oldIsSlashChord: Bool = false
//      
//      if let oldResultChordVoicingCalculator = oldMultiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
//        oldIsSlashChord = oldResultChordVoicingCalculator.isSlashChord == true ? true : false
//      }
//      
//      let oldLowerStackedPitches = oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches
//      let oldUpperStackedPitches = oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
//      
//      let (oldLowerSplitPitches, oldUpperSplitPitches) = oldMultiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: oldLowerStackedPitches, upperPitches: oldUpperStackedPitches)
//      
//      lowerKeyboard.toggleHighlightKeysSingle(degreeNumbers: oldLowerStackedPitches, color: color)
//      upperKeyboard.toggleHighlightKeysSingle(degreeNumbers: oldUpperStackedPitches, color: secondColor)
//      
//      lowerKeyboard.toggleHighlightKeysSingle(degreeNumbers: lowerStackedPitches, color: color)
//      upperKeyboard.toggleHighlightKeysSingle(degreeNumbers: upperStackedPitches, color: secondColor)
//      
//      combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//        onlyInLower: oldMultiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//        onlyInUpper: oldMultiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//        commonTones: oldMultiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//        lowerStackedPitches: oldLowerSplitPitches,
//        upperStackedPitches: oldUpperSplitPitches,
//        resultChordExists: oldResultChordExists,
//        isSlashChord: oldIsSlashChord,
//        color: color,
//        secondColor: secondColor)
//      combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//        onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//        onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//        commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//        lowerStackedPitches: lowerSplitPitches,
//        upperStackedPitches: upperSplitPitches,
//        resultChordExists: resultChordExists,
//        isSlashChord: isSlashChord,
//        color: color,
//        secondColor: secondColor)
//    }
//    
//    //    print(multiChord.resultChord?.preciseName)
//    
//    oldMultiChord.lowerChord = multiChord.lowerChord
//    oldMultiChord.upperChord = multiChord.upperChord
//  }
//  
//  func highlightSingleKeyboard(multiChord: MultiChord, oldMultiChord: MultiChord, keyboard: inout Keyboard, color: Color) {
//    let resultChordExists: Bool = multiChord.resultChord != nil ? true : false
//    
//    let stackedPitches = multiChord.multiChordVoicingCalculator.lowerStackedPitches
//    let upperStackedPitches = multiChord.multiChordVoicingCalculator.upperStackedPitches
//    
//    let (lowerSplitPitches, upperSplitPitches) = multiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: stackedPitches, upperPitches: upperStackedPitches)
//    
//    
//    let oldResultChordExists: Bool = oldMultiChord.resultChord != nil ? true : false
//
//    
//    let oldLowerStackedPitches = oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches
//    let oldUpperStackedPitches = oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
//    
//    let (oldLowerSplitPitches, oldUpperSplitPitches) = oldMultiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: oldLowerStackedPitches, upperPitches: oldUpperStackedPitches)
//    
//    keyboard.toggleHighlightKeysSingle(degreeNumbers: oldLowerStackedPitches, color: color)
//    
//    keyboard.toggleHighlightKeysSingle(degreeNumbers: stackedPitches, color: color)
//  }
//  
//  func highlightCombinedKeyboard(multiChord: MultiChord, oldMultiChord: MultiChord, combinedKeyboard: inout Keyboard, color: Color, secondColor: Color) {
//    let resultChordExists: Bool = multiChord.resultChord != nil ? true : false
//    var isSlashChord: Bool = false
//    
//    if let resultChordVoicingCalculator = multiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
//      isSlashChord = resultChordVoicingCalculator.isSlashChord == true ? true : false
//    }
//    
//    let stackedPitches = multiChord.multiChordVoicingCalculator.lowerStackedPitches
//    let upperStackedPitches = multiChord.multiChordVoicingCalculator.upperStackedPitches
//    
//    let (lowerSplitPitches, upperSplitPitches) = multiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: stackedPitches, upperPitches: upperStackedPitches)
//    
//    
//    let oldResultChordExists: Bool = oldMultiChord.resultChord != nil ? true : false
//    var oldIsSlashChord: Bool = false
//    
//    if let oldResultChordVoicingCalculator = oldMultiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
//      oldIsSlashChord = oldResultChordVoicingCalculator.isSlashChord == true ? true : false
//    }
//    
//    let oldLowerStackedPitches = oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches
//    let oldUpperStackedPitches = oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
//    
//    let (oldLowerSplitPitches, oldUpperSplitPitches) = oldMultiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: oldLowerStackedPitches, upperPitches: oldUpperStackedPitches)
//    
//    combinedKeyboard.toggleHighlightKeysSingle(degreeNumbers: oldLowerStackedPitches, color: color)
//    
//    combinedKeyboard.toggleHighlightKeysSingle(degreeNumbers: stackedPitches, color: color)
//    
//    combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//      onlyInLower: oldMultiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//      onlyInUpper: oldMultiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//      commonTones: oldMultiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//      lowerStackedPitches: oldLowerSplitPitches,
//      upperStackedPitches: oldUpperSplitPitches,
//      resultChordExists: oldResultChordExists,
//      isSlashChord: oldIsSlashChord,
//      color: color,
//      secondColor: secondColor)
//    combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//      onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//      onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//      commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//      lowerStackedPitches: lowerSplitPitches,
//      upperStackedPitches: upperSplitPitches,
//      resultChordExists: resultChordExists,
//      isSlashChord: isSlashChord,
//      color: color,
//      secondColor: secondColor)
//  }
//  
//}
