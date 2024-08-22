//
//  AlignmentTestView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/16/24.
//

import SwiftUI

struct AlignmentTestView: View {
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
      Rectangle()
        .frame(width: 23, height: 96)
        .alignmentGuide(VerticalAlignment.top) { d in
          d[.top]
        }
        .alignmentGuide(HorizontalAlignment.leading) { d in
          d[.leading] + 20
        }
        .foregroundStyle(.red)
      Rectangle()
        .frame(width: 14, height: 52)
        .alignmentGuide(VerticalAlignment.top) { d in
          d[.top]
        }
        .alignmentGuide(HorizontalAlignment.leading) { d in
          d[.leading] - 0
        }
        .foregroundStyle(.green)
    }
    .frame(width: 33, height: 96)
    .border(Color.black)
  }
}

#Preview {
  AlignmentTestView()
}
