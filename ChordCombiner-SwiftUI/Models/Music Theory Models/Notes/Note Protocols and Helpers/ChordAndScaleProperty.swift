//
//  ChordAndScaleProperty.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/19/24.
//

import Foundation
import SwiftUI


protocol ChordAndScaleProperty: CaseIterable, Identifiable, Codable, RawRepresentable where RawValue == String {}
