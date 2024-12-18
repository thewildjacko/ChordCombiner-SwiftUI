//
//  KeyName+DegreeMaps.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/17/24.
//

import Foundation

extension KeyName {
  static let zeroMapSharp: [Degree: KeyName] = [
    Degree.root: KeySwitcher.sharp.root(rootNumber: .zero),
    .octave: KeySwitcher.sharp.root(rootNumber: .zero),
    .perfect15th: KeySwitcher.sharp.root(rootNumber: .zero),
    .minor2nd: KeySwitcher.sharp.minor9th(rootNumber: .zero),
    .flat9th: KeySwitcher.sharp.minor9th(rootNumber: .zero),
    .major2nd: KeySwitcher.sharp.major9th(rootNumber: .zero),
    .major9th: KeySwitcher.sharp.major9th(rootNumber: .zero),
    .sharp2nd: KeySwitcher.sharp.sharp9th(rootNumber: .zero),
    .sharp9th: KeySwitcher.sharp.sharp9th(rootNumber: .zero),
    .minor3rd: KeySwitcher.sharp.minor3rd(rootNumber: .zero),
    .minor10th: KeySwitcher.sharp.minor3rd(rootNumber: .zero),
    .major3rd: KeySwitcher.sharp.major3rd(rootNumber: .zero),
    .major10th: KeySwitcher.sharp.major3rd(rootNumber: .zero),
    .perfect4th: KeySwitcher.sharp.perfect4th(rootNumber: .zero),
    .perfect11th: KeySwitcher.sharp.perfect4th(rootNumber: .zero),
    .sharp4th: KeySwitcher.sharp.sharp4th(rootNumber: .zero),
    .sharp11th: KeySwitcher.sharp.sharp4th(rootNumber: .zero),
    .diminished5th: KeySwitcher.sharp.dim5th(rootNumber: .zero),
    .flat12th: KeySwitcher.sharp.dim5th(rootNumber: .zero),
    .perfect5th: KeySwitcher.sharp.perfect5th(rootNumber: .zero),
    .perfect12th: KeySwitcher.sharp.perfect5th(rootNumber: .zero),
    .sharp5th: KeySwitcher.sharp.sharp5th(rootNumber: .zero),
    .sharp12th: KeySwitcher.sharp.sharp5th(rootNumber: .zero),
    .minor6th: KeySwitcher.sharp.minor6th(rootNumber: .zero),
    .flat13th: KeySwitcher.sharp.minor6th(rootNumber: .zero),
    .major6th: KeySwitcher.sharp.major6th(rootNumber: .zero),
    .major13th: KeySwitcher.sharp.major6th(rootNumber: .zero),
    .diminished7th: KeySwitcher.sharp.dim7th(rootNumber: .zero),
    .diminished14th: KeySwitcher.sharp.dim7th(rootNumber: .zero),
    .minor7th: KeySwitcher.sharp.minor7th(rootNumber: .zero),
    .minor14th: KeySwitcher.sharp.minor7th(rootNumber: .zero),
    .major7th: KeySwitcher.sharp.major7th(rootNumber: .zero),
    .major14th: KeySwitcher.sharp.major7th(rootNumber: .zero)
  ]

  static let zeroMapFlat: [Degree: KeyName] = [
    Degree.root: KeySwitcher.flat.root(rootNumber: .zero),
    .octave: KeySwitcher.flat.root(rootNumber: .zero),
    .perfect15th: KeySwitcher.flat.root(rootNumber: .zero),
    .minor2nd: KeySwitcher.flat.minor9th(rootNumber: .zero),
    .flat9th: KeySwitcher.flat.minor9th(rootNumber: .zero),
    .major2nd: KeySwitcher.flat.major9th(rootNumber: .zero),
    .major9th: KeySwitcher.flat.major9th(rootNumber: .zero),
    .sharp2nd: KeySwitcher.flat.sharp9th(rootNumber: .zero),
    .sharp9th: KeySwitcher.flat.sharp9th(rootNumber: .zero),
    .minor3rd: KeySwitcher.flat.minor3rd(rootNumber: .zero),
    .minor10th: KeySwitcher.flat.minor3rd(rootNumber: .zero),
    .major3rd: KeySwitcher.flat.major3rd(rootNumber: .zero),
    .major10th: KeySwitcher.flat.major3rd(rootNumber: .zero),
    .perfect4th: KeySwitcher.flat.perfect4th(rootNumber: .zero),
    .perfect11th: KeySwitcher.flat.perfect4th(rootNumber: .zero),
    .sharp4th: KeySwitcher.flat.sharp4th(rootNumber: .zero),
    .sharp11th: KeySwitcher.flat.sharp4th(rootNumber: .zero),
    .diminished5th: KeySwitcher.flat.dim5th(rootNumber: .zero),
    .flat12th: KeySwitcher.flat.dim5th(rootNumber: .zero),
    .perfect5th: KeySwitcher.flat.perfect5th(rootNumber: .zero),
    .perfect12th: KeySwitcher.flat.perfect5th(rootNumber: .zero),
    .sharp5th: KeySwitcher.flat.sharp5th(rootNumber: .zero),
    .sharp12th: KeySwitcher.flat.sharp5th(rootNumber: .zero),
    .minor6th: KeySwitcher.flat.minor6th(rootNumber: .zero),
    .flat13th: KeySwitcher.flat.minor6th(rootNumber: .zero),
    .major6th: KeySwitcher.flat.major6th(rootNumber: .zero),
    .major13th: KeySwitcher.flat.major6th(rootNumber: .zero),
    .diminished7th: KeySwitcher.flat.dim7th(rootNumber: .zero),
    .diminished14th: KeySwitcher.flat.dim7th(rootNumber: .zero),
    .minor7th: KeySwitcher.flat.minor7th(rootNumber: .zero),
    .minor14th: KeySwitcher.flat.minor7th(rootNumber: .zero),
    .major7th: KeySwitcher.flat.major7th(rootNumber: .zero),
    .major14th: KeySwitcher.flat.major7th(rootNumber: .zero)
  ]
}
