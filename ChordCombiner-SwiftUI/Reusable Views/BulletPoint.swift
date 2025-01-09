//
//  BulletPoint.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/7/25.
//

import SwiftUI

enum BulletStyle: String {
    case dash = "-"
    case dot = "•"
}

struct BulletPoint: View, Identifiable {
    var id: UUID = UUID()
    var text: String
    var bulletStyle: BulletStyle = .dot
    var indentation: CGFloat = 0

    init (
        text: String,
        bulletStyle: BulletStyle = .dot,
        indentation: CGFloat = 0) {
        self.text = text
        self.bulletStyle = bulletStyle
            self.indentation = indentation
    }

    var body: some View {
        HStack(alignment: .top) {
            Text(bulletStyle.rawValue)
            Text(text)
        }
        .foregroundStyle(.title)
        .padding(.leading, 5 + indentation)
        .padding(.trailing, 5)
    }
}

struct BulletList: View {
    var bulletPoints: [BulletPoint]
    var indentation: CGFloat = 20

    init(bulletPoints: [BulletPoint], indentation: CGFloat = 20) {
        self.bulletPoints = bulletPoints
        self.indentation = indentation
    }

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(bulletPoints, id: \.id) { bulletPoint in
                bulletPoint
            }
        }
        .padding(.leading, indentation)
        .padding(.bottom, 5)
    }
}
