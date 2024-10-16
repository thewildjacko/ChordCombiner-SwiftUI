          VStack {
            TitleView(text: "Select Lower Chord", font: .headline, weight: .heavy, isMenuTitle: false)
            
            NavigationLink(
              destination:
                CustomChordMenu(
                  chord: $multiChord.lowerChord,
                  keyboard: $lowerKeyboard,
                  selectedLetter: $multiChord.lowerChord.letter, selectedAccidental: $multiChord.lowerChord.accidental,
                  selectedChordType: $multiChord.lowerChord.type,
                  color: .yellow
                )
                .navigationTitle("Select Lower Chord")
                .navigationBarTitleDisplayMode(.inline)
            ) {
              VStack(spacing: 15) {
                TitleView(
                  text: multiChord.lowerChord.type == .ma ? multiChord.lowerChord.root.noteName : multiChord.lowerChord.preciseName,
                  font: .largeTitle,
                  weight: .heavy,
                  color: .button
                )
                
                lowerKeyboard
              }
            }
          }