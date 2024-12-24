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

These three keyboards are managed by an `@Observable` and `@Bindable` **`ChordCombinerViewModel`** singleton, which also contains 3 optional `Chord` objects:

- `lowerChord`
  - displays on `lowerKeyboard`, and also on `combinedKeyboard` if only `lowerChord` is selected
- `upperChord
  - displays on `upperKeyboard`, and also on `combinedKeyboard` if only `upperChord` is selected
- `resultChord`
  - displays on `combinedKeyboard`, if a `Chord` match exists, once both `lowerChord` and `upperChord` are selected.

### Data Persistance

`ChordCombinerViewModel` uses JSON to store and load the `ChordPropertyData` selections (a struct containing optional `Letter`, ``RootAccidental` and `ChordType` properties). This JSON data is loaded when `ChordCombinerView` appears; if no JSON file is found, the `loadJSON` method sets all ChordPropertyData properties to `nil` and the app presents the intial launch state.

#### Initial Functionality

The user can tap either `ChordCombinerMenuCoverView` navigation link to navigate to the **`ChordCombinerChordSelectionMenu`**, the main interactive section of the app.

Once an **Upper Chord** or **Lower Chord** is selected for either CoverView, the titles update to reflect the Chord symbol, and the keyboards highlight the keys of that chord appropriately _(blue for Lower, yellow for Upper)_.

An info navigation link also appears next to the chord symbol, which the user can tap to go to a `SingleChordDetailView` providing more information about the chord. These elements also appear above the **Combined Keyboard** before both chords are selected.

Once both **Upper** and **Lower** chords are selected, the app **Combined Keyboard** `ChordCombinerChordSelectionMenu` initially displays the following:

### `SingleChordTitleNavigationStackView`
   - _"Select Lower/Upper Chord"_ 
   - _"Please select a chord"_ (changes to chord symbol once the `Chord` is selected)
   - A 2-octave **Upper or Lower Keyboard**
   - _"Select upper and lower chords to show matches"_ (this disappears once both chords are selected)

### User Interaction: `ChordCombinerPropertySelectionView`

  - A horizontal row with custom `Letter` and Accidental (`RootAccidental`) pickers (`ChordCombinerTagsView`).
    - in the Accidental picker, the &#x266E; sign is pre-selected for convience
  - A vertical List with keyboards for every triad and simple 4-note `ChordType`, initially displaying the title of the `ChordType` with no Letter or Accidental prefix
    - once a ChordType is selected, the List automatically scrolls to that `ChordType` position if the user leaves the selection screen and comes back later.
  
  #### Protocol Oriented Programming
  - `Letter`, `RootAccidental` and `ChordType` conform to the **`ChordAndScaleProperty`** protocol
    - This allows for a single reusable `ChordCombinerTagsView` for both the `Letter` and `RootAccidental` pickers.
    - `ChordAndScaleProperty` is also used in `ChordCombinerPropertyMatcher` to highlight the `Letter`, `RootAccidental` and `ChordType` picker items to show matching properties.
  
  
  #### Data Persistence
  Every time the user selects a new property, the `chordPropertyData` property of `ChordCombinerViewModel` is updated and the `saveJSON` method stores the data.

  #### Functionality
  
  The user can tap on any letter, accidental or ChordType to select it; that chord property will then become highlighted in a blue-green color.

  - Once the user has selected all 3 chord properties (Letter, Accidental & ChordType), the keyboards in the ChordType list highlight with chords in the selected `RootKeyNote`, and the keyboard titles update to match.
  - Once the user selects both a **Lower** and an **Upper** chord, the `ChordAndScaleProperty` tags light up in purple, and/or with a purple glow, based on matches to the chord not currently being selected, as follows:
    - A **blue-green background** if the tag is _currently selected_
    - A **purple glow and background** if the tag is NOT _currently selected_, but _matches_ the chord currently being selected
    - A **blue-green background** AND a **purple glow** if the tag is both _currently selected_ and _matches_ the chord current;y being selected.
    - A **gray background with no glow** if the tag is _unselected and also does not match_

  ChordType `Keyboards` light up similarly, with the following differences:
    - Only the chord symbol changes color, and does not glow (for readability purposes)
      - Instead, the `Keyboard` displays a **purple glow** if it matches
    - The chord symbol is **blue-green** if selected, **purple** if it matches, and **white** if it's unselected and doesn't match.
    - Additionally, a _purple text label_ stating **"match found!"** appears to the right of the keyboard tag if a `ChordType` matches.
    

  #### Example:

  The user is in the **Lower Chord** `ChordCombinerChordSelectionMenu`. **Cma7** is already selected, and **Dma** is selected for the upper chord. The following ``ChordAndScaleProperty`` tags will light up based on matches to the _upper chord_, **Dma**, as follows:

  - The **C** tag will light up with a **blue-green background** and a **purple glow**, because **C** is selected and **Cma** also matches as an _upper chord_ for **Cma7**.
  - **D, G and A** light up in **purple** because they match, but are not selected.
  - The **natural** sign also displays a **blue-green background** and a **purple glow**, because it's selected and matches
  - The **Cma, Cmi, C+ and C**˚ keyboards (among others) glow in purple, their chord symbols change to purple, and the **match found** label displays, because all 4 chords match as upper chords to **Cma7**.
  - The **Csus4 and Csus2**˚ keyboards (among others) do not glow, their chord symbols stay white, and the **match found** label does not display, because neither chord match as upper chords to **Cma7**.
  - The **Cma7**˚ keyboard glows in purple, its chord symbols displays in blue-green, and the **match found** label displays, because it is selected and it matches as an upper chord to **Cma7**.


   
- A 2-octave **Upper Keyboard** (`ChordCombinerMenuCoverView`)
  - Initial title: "Select Upper Chord"
  - Navigation link: "Please select a chord"  + the Keyboard itself
- A 3-octave **Combined keyboard** `DualChordKeyboardView`
  - Initial title: "waiting for chord selection..."