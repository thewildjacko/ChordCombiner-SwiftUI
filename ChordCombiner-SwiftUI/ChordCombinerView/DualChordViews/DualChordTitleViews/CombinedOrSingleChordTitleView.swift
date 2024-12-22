//
//  CombinedOrSingleChordTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//

import SwiftUI

struct CombinedOrSingleChordTitleView: View {
  var titleText: String
  var titleFont: Font

  var body: some View {
    HStack {
      DualChordTitleView(
        titleText: titleText,
        titleFont: titleFont,
        showCaption: false,
        showTitle: true)
      DualChordDetailNavigationLinkView(
        showCaption: true)
    }
  }
}
