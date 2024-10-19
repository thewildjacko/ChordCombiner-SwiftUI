//
//  TitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/10/24.
//

import SwiftUI

struct TitleView: View {
  var text: String
  var font: Font = .largeTitle
  var weight: Font.Weight = .regular
  var color: Color = .title
  var isMenuTitle: Bool = false
  
    var body: some View {
      if !isMenuTitle {
        Text(text)
          .titleFormat(font: font, weight: weight, color: color)
      } else {
        Text(text)
          .menuTitleFormat(font: font, weight: weight)
      }
    }
}

#Preview {
  TitleView(text: "Cma13", font: .largeTitle, weight: .heavy)
}
