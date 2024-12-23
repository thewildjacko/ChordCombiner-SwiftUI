# Chord Combiner

![ChordCombiner Light Mode Icon large-keyboards += 128px.jpg](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner%20Light%20Mode%20Icon%20large-keyboards%20%2B%3D%20128px.jpg)

Piano-focused music theory & harmony app designed to help musicians learn about the connections between different chords. The core functionality is a chord calculator.

[View Navigation Map](https://bra.in/5jMZEP)

## Initial Screen: ChordCombinerView

Upon loading, the app presents the `ChordCombinerView`, which displays a column of 3 `Keyboard` views, initially with no keys highlighted:

- A 2-octave **Lower Keyboard** (`ChordCombinerMenuCoverView`)
  - Initial title: _"Select Lower Chord"_
  - Navigation link: _"Please select a chord"_ + the Keyboard itself
- A 2-octave **Upper Keyboard** (`ChordCombinerMenuCoverView`)
  - Initial title: _"Select Upper Chord"_
  - Navigation link: _"Please select a chord"_ + the Keyboard itself
- A 3-octave **Combined keyboard** `DualChordKeyboardView`
  - Initial title: _"waiting for chord selection..."_

These three keyboards are managed by a **`ChordCombinerViewModel`** singleton, which also contains 3 optional `Chord` objects:

- `lowerChord`
  - displays on `lowerKeyboard`, and also on `combinedKeyboard` if only `lowerChord` is selected
- `upperChord
  - displays on `upperKeyboard`, and also on `combinedKeyboard` if only `upperChord` is selected
- `resultChord`
  - displays on `combinedKeyboard`, if a `Chord` match exists, once both `lowerChord` and `upperChord` are selected.

### Data Persistance

`ChordCombinerViewModel` uses JSON to store and load the `ChordPropertyData` selections (a struct containing optional `Letter`, ``RootAccidental` and `ChordType` properties). This JSON data is loaded when `ChordCombinerView` appears; if no JSON file is found, the `loadJSON` method sets all ChordPropertyData properties to `nil` and the app presents the intial launch state.

#### Initial Functionality

The user can tap either `ChordCombinerMenuCoverView` navigation link to navigate to the `ChordCombinerChordSelectionMenu`, the main interactive section of the app.

Once an **Upper Chord** or **Lower Chord** is selected for either CoverView, the titles update to reflect the Chord symbol, and the keyboards highlight the keys of that chord appropriately _(blue for Lower, yellow for Upper)_.

An info navigation link also appears next to the chord symbol, which the user can tap to go to a `SingleChordDetailView` providing more information about the chord. These elements also appear above the **Combined Keyboard** before both chords are selected.

Once both **Upper** and **Lower** chords are selected, the app **Combined Keyboard** 

## `ChordCombinerChordSelectionMenu` initially displays the following:

### `SingleChordTitleNavigationStackView`
   - _"Select Lower/Upper Chord"_
   - _"Please select a chord"_
   - A 2-octave **Upper or Lower Keyboard**
   - _"Select upper and lower chords to show matches"_

### `ChordCombinerPropertySelectionView`

  - A horizontal row with custom Letter and Accidental (`RootAccidental`) pickers
    - in the Accidental picker, the &#x266E; sign is pre-selected for convience
  - A vertical List with keyboards for every triad and simple 4-note `ChordType`, initially displaying the title of the `ChordType` with no Letter or Accidental prefix
    - once a ChordType is selected, the List automatically scrolls to that `ChordType` position if the user leaves the selection screen and comes back later.
    
  #### Functionality
  
  The user can tap on any letter, accidental or ChordType to select it; that chord property will then become highlighted in a blue-green color.

  Once the user has selected all 3 chord properties (Letter, Accidental & ChordType), the keyboards in the ChordType list highlight with chords in the selected `RootKeyNote`, and the keyboard titles update to match.

   
- A 2-octave **Upper Keyboard** (`ChordCombinerMenuCoverView`)
  - Initial title: "Select Upper Chord"
  - Navigation link: "Please select a chord"  + the Keyboard itself
- A 3-octave **Combined keyboard** `DualChordKeyboardView`
  - Initial title: "waiting for chord selection..."