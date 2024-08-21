//
//  Colors.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import UIKit
import SwiftUI

let ccBlueGreen = UIColor(red: 115/255, green: 252/255, blue: 214/255, alpha: 1)

extension LinearGradient {
  public static func commonTone(_ color1: Color, _ color2: Color) -> LinearGradient {
    return LinearGradient(stops: [
      .init(color: color1, location: 0.20),
      //          .init(color: color1, location: 0.10),
      //          .init(color: color2, location: 0.10),
      //          .init(color: color2, location: 0.20),
      //          .init(color: color1, location: 0.20),
      //          .init(color: color1, location: 0.30),
      //          .init(color: color2, location: 0.30),
      ////          .init(color: color2, location: 0.40),
      ////          .init(color: color1, location: 0.40),
      ////          .init(color: color1, location: 0.50),
      ////          .init(color: color2, location: 0.50),
      //          .init(color: color2, location: 0.60),
      //          .init(color: color1, location: 0.60),
      ////          .init(color: color1, location: 0.70),
      ////          .init(color: color2, location: 0.70),
      ////          .init(color: color2, location: 0.80),
      ////          .init(color: color1, location: 0.80),
      ////          .init(color: color1, location: 0.90),
      ////          .init(color: color2, location: 0.90),
        .init(color: color2, location: 0.80)
    ], startPoint: .topLeading, endPoint: .bottomTrailing)
  }
}
