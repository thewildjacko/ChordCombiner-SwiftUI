# Chord Combiner

![ChordCombiner Light Mode Icon large-keyboards += 128px.jpg](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner%20Light%20Mode%20Icon%20large-keyboards%20%2B%3D%20128px.jpg)

Piano-focused music theory & harmony app designed to help musicians learn about the connections between different chords. The core functionality is a chord calculator.

[View Navigation Map](https://bra.in/5jMZEP)

## Initial Screen: ChordCombinerView

Upon loading, the app presents the `ChordCombinerView`, which displays a column of 3 `Keyboard` views, initially with no keys highlighted:

- A 2-octave **Lower Keyboard** (`ChordCombinerMenuCoverView`)
  - Initial title: "Select Lower Chord"
  - Navigation link: "Please select a chord" + the Keyboard itself
- A 2-octave **Upper Keyboard** (`ChordCombinerMenuCoverView`)
  - Initial title: "Select Upper Chord"
  - Navigation link: "Please select a chord"  + the Keyboard itself
- A 3-octave **Combined keyboard** `DualChordKeyboardView`
  - Initial title: "waiting for chord selection..."

The user can tap the navigation links to 
