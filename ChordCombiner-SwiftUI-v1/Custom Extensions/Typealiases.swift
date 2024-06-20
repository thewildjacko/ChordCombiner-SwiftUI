//
//  Custom Extensions.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 5/24/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation

typealias ChordStats = (letter: Letter, accidental: RootAcc, type: QualProtocol)

typealias GetComboChordAndScale = (RootGen, Set<Int>, Int)
typealias RootGen = KeyName.RootGen
typealias RootAcc = Accidental.RootAcc

typealias TriadType = Triad.TriadType
typealias FNCType = FourNoteChord.FNCType
typealias TriadInversion = Triad.TriadInversion
typealias FNCInversion = FourNoteChord.FNCInversion


typealias Alterations = ChordDegrees.Alterations
typealias Extensions = ChordDegrees.Extensions
typealias GuideTones = ChordDegrees.GuideTones
typealias TensionTones = ChordDegrees.TensionTones
typealias TCArray = ChordDegrees.TCArray

typealias DegInt = DegName.Deg
