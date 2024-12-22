//
//  InfoLinkImageView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct InfoLinkImageView: View {
  var font: Font = .title3

    var body: some View {
      Image(systemName: "info.circle")
        .font(font)
        .foregroundStyle(.title)
    }
}

#Preview {
    InfoLinkImageView()
}
