//
//  ChordType+degreeTypeIDGroups.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/16/24.
//

import Foundation

// MARK: degreeTag identifier groups
extension ChordType {
  var has2nd: Bool {
    degreeTags.intersectsWith([.major2nd])
  }

  var has3rd: Bool {
    degreeTags.intersectsWith([.major3rd, .minor3rd])
  }

  var has4th: Bool {
    degreeTags.intersectsWith([.perfect4th, .sharp4th])
  }

  var has5th: Bool {
    degreeTags.intersectsWith([.diminished5th, .perfect5th, .sharp5th])
  }

  var has6th: Bool {
    degreeTags.intersectsWith([.major6th, .minor6th])
  }

  var has7th: Bool {
    degreeTags.intersectsWith([.major7th, .minor7th, .diminished7th])
  }

  var has9th: Bool {
    degreeTags.intersectsWith([.flat9th, .major9th, .sharp9th])
  }

  var is9thChord: Bool {
    degreeTags.intersectsWith([.flat9th, .major9th, .sharp9th]) &&
    !(degreeTags.intersectsWith([.perfect11th, .sharp11th]) &&
      degreeTags.intersectsWith([.major13th, .flat13th]))
  }

  var has11th: Bool {
    degreeTags.intersectsWith([.perfect11th, .sharp11th])
  }

  var is11thChord: Bool {
    degreeTags.intersectsWith([.perfect11th, .sharp11th]) &&
    !degreeTags.intersectsWith([.major13th, .flat13th])
  }

  var is13thChord: Bool {
    degreeTags.intersectsWith([.major13th, .flat13th])
  }

  var hasOneMiddleTriadNote: Bool {
    (has2nd || has3rd || has4th)
  }

  var hasTwoMiddleTriadNotes: Bool {
    (has2nd && has3rd) || (has2nd && has4th) || (has3rd && has4th)
  }

  var isTriad: Bool {
    degreeNumbers.count == 3 &&
    degreeTags.contains(.root) &&
    hasOneMiddleTriadNote &&
    !hasTwoMiddleTriadNotes &&
    has5th
  }

  var isModifiedTriad: Bool {
    degreeTags.contains(.root) &&
    hasTwoMiddleTriadNotes &&
    has5th
  }

  var isExtendedChord: Bool {
    degreeTags.intersectsWith(
      [
        .flat9th,
        .major9th,
        .sharp9th,
        .perfect11th,
        .sharp11th,
        .major13th,
        .flat13th
      ]
    ) ||
    degreeTags.contains([.diminished7th, .major7th])
  }

  var isFourNote6thChord: Bool {
    degreeTags.count == 4 &&
    !isExtendedChord &&
    has6th
  }

  var isFourNote7thChord: Bool {
    degreeTags.count == 4 &&
    !isExtendedChord &&
    has7th
  }

  var isFourNoteSimpleChord: Bool {
    degreeTags.count == 4 &&
    !isExtendedChord &&
    (has6th || has7th || isModifiedTriad)
  }

  var isSimpleChord: Bool {
    isTriad || isFourNoteSimpleChord
  }
}
