 # Chord Combiner

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/4c9f94b899bda454ddde198239e05e48797a76ad/ChordCombiner%20Light%20Mode%20Splash%20Icon%20large-keyboards%20%2B%3D%20v3.png" alt="Chord Combiner Light Mode" width="128" height="128">

Jazz piano-focused music theory & harmony app designed to help musicians recall and apply complex chords by breaking them down into smaller components. The core functionality is a chord calculator that combines the numeric degrees of two user-selected chords—a lower chord and an upper chord—and returns one of 3 results:

1. A **unified chord** *(single chord symbol with no alternate bass)*
2. A **slash chord** *(single chord symbol over an alternate bass)*
3. A **polychord** *(two chord symbols, one over the other)*

After selecting lower and upper chords, the user can view each chord's notes highlighted on separate piano keyboards, stacked in order of chord degree size, with the names of the notes displayed above the keyboard. They can also view the combined result on a 3rd keyboard, with each chords' notes highlighted in different colors. Glyphs are also displayed on the notes to show which chord each note belongs to.

After viewing the chords on the main page, the user can then navigate to detail pages with more information about the resulting chord or chords. Possible information displayed includes:

 - notes
 - degrees
 - component chords (lower & upper)
 - base chord, notes and degrees
 - extended notes
 - equivalent chords

For any chord listed in a detail view, the user can navigate further to another detail view in order to view information about that chord.

Finally, the user can tap a link in the detail page to view a mind map-style graph of all four-note chords, triads, and notes contained in the currently displayed chord. This graph uses data from the [image-charts](http://image-charts.com) API, using [graphviz dot language](https://graphviz.org/doc/info/lang.html) to build the URL.
   
[View Navigation Map](https://app.thebrain.com/brain/2386d191-7ecd-4581-8c39-9b8a5e16722f/b317b021-f918-4cb2-a72f-7da1aa422953)

## Concepts Used

### Protocols

The app uses protocols throughout to enforce conformance for custom types, and for composition. In [ChordCombinerPropertySelectionView](ChordCombinerPropertySelectionView.swift), the app uses protocols and generics to facilitate reusuable views and functions for different types of data (see [Protocol Oriented Programming])(#protocol-oriented-programming).

## JSON Data Persistence
The app uses JSON to store essential data. See [Data Persistence](#data-persistence) and [Save On Select](#save-on-select)

## Initial Screen: [ChordCombinerView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/ChordCombinerView.swift)

<img src="ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20initial%20screen.PNG" alt="Initial Screen" width="341" height="694.5">

This is the main view of the app. It displays 3 `Keyboard` views, initially with no keys highlighted.

The user can tap either the upper or lower keyboards or their titles, displayed with [ChordCombinerMenuCoverView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/86f06c6e1e2b459d056f4d0d313565524b2905dc/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerMenuCoverView.swift), to move on to the next screen, [ChordCombinerChordSelectionMenu](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c050522459a11841f6656c9561bd946cb27c83b6/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerChordSelectionMenu.swift).

After users have selected lower and/or upper keyboards, they can return to [ChordCombinerView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/ChordCombinerView.swift) to see a visual overview of their selections. The below screenshots show the different outcomes for `ChordCombinerView`:

#### Lower chord selected / Upper Chord selected
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/42f834db6546605a994ba4fc1a3fdd8f42b7dce4/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20lower%20chord%20selected.PNG" alt="ChordCombinerView - Lower chord selected" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20upper%20chord%20selected.PNG" alt="ChordCombinerView - Upper chord selected" width="341" height="694.5">

#### Both chords selected - Combined, slash and split chord results
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/42f834db6546605a994ba4fc1a3fdd8f42b7dce4/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20combined%20chord%20view.PNG" alt="ChordCombinerView - Both chords selected, combined chord" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/42f834db6546605a994ba4fc1a3fdd8f42b7dce4/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20slash%20chord%20view.PNG" alt="ChordCombinerView - Both chords selected, slash chord" width="341" height="694.5"> 
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/42f834db6546605a994ba4fc1a3fdd8f42b7dce4/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20split%20chord%20view.PNG" alt="ChordCombinerView - Both chords selected, split chord" width="341" height="694.5">

The `ChordCombinerKeyboards` are managed by an `@Observable` and `@Bindable` **[ChordCombinerViewModel](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c7c78c4e8dcec283ece306f90bde7dbb2dc14aa5/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerViewModel.swift)** singleton, which also contains 3 optional `Chord` objects:

- `lowerChord`
  - displays on `lowerKeyboard`, and also on `combinedKeyboard` if only `lowerChord` is selected
- `upperChord
  - displays on `upperKeyboard`, and also on `combinedKeyboard` if only `upperChord` is selected
- `resultChord`
  - displays on `combinedKeyboard`, if a `Chord` match exists, once both `lowerChord` and `upperChord` are selected.

These three Chord objects control what notes are highlighted on each of the 3 main keyboards, and also which data to display for [DualChordDetailView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c7c78c4e8dcec283ece306f90bde7dbb2dc14aa5/ChordCombiner-SwiftUI/DualChordViews/DualChordDetailView.swift).

### Data Persistence

`ChordCombinerViewModel` uses JSON to store and load the [ChordPropertyData](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordProperties/ChordPropertiesModels/ChordPropertyData.swift) selections (a struct containing optional [Letter](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Letter.swift), [RootAccidental](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Accidental.swift) and [ChordType](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Chords/ChordType/ChordType.swift) properties). This JSON data is loaded when `ChordCombinerView` appears; if no JSON file is found, the `loadJSON` method sets all `ChordPropertyData` properties to `nil` and the app presents the intial launch state.

## [User Interaction - ChordCombinerChordSelectionMenu](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c050522459a11841f6656c9561bd946cb27c83b6/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerChordSelectionMenu.swift)

### Functionality
  
  The user can tap on any letter, accidental or ChordType in [ChordCombinerPropertySelectionView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/cc31ea3f73093f07bfde58a7834a33fa93a48536/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerPropertySelectionView.swift) to select it; that chord property will then become highlighted in a **blue-green color**.

  - Once the user has selected all 3 chord properties (Letter, Accidental & ChordType), the keyboards in the ChordType list highlight with chords in the selected `RootKeyNote`, and the keyboard titles update to match.
  - Once the user selects both a **Lower** and an **Upper** chord, the `ChordAndScaleProperty` tags light up in **purple, and/or with a purple glow**, based on matches to the chord not currently being selected.

The highlighting works as follows:
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

  - **Letter Tags**
    - The **C** tag will light up with a **blue-green background** and a **purple glow**, because **C** is selected and **Cma** also matches as an _upper chord_ for **Cma7**.
    - **D, G and A** light up in **purple** because they match, but are not selected.
  - Accidental Tags
    - The **natural** sign displays a **blue-green background** and a **purple glow**, because it's selected and matches
  - ChordType Keyboard Tags
    - The **Cma, Cmi, C+ and C**˚ keyboards (among others) glow in purple, their chord symbols change to purple, and the **match found** label displays, because all 4 chords match as upper chords to **Cma7**.
    - The **Csus4 and Csus2**˚ keyboards (among others) do not glow, their chord symbols stay white, and the **match found** label does not display, because neither chord match as upper chords to **Cma7**.
    - The **Cma7**˚ keyboard glows in purple, its chord symbols displays in blue-green, and the **match found** label displays, because it is selected and it matches as an upper chord to **Cma7**.
    - 
#### `ChordCombinerPropertySelectionView`
  - A horizontal row with custom `Letter` and Accidental (`RootAccidental`) pickers (`ChordCombinerTagsView`).
    - in the Accidental picker, the &#x266E; sign is pre-selected for convience
  - A vertical List with keyboards for every triad and simple 4-note `ChordType`, initially displaying the title of the `ChordType` with no Letter or Accidental prefix
    - once a ChordType is selected, the List automatically scrolls to that `ChordType` position if the user leaves the selection screen and comes back later.
  
  ##### Protocol Oriented Programming
  - `Letter`, `RootAccidental` and `ChordType` conform to the **`ChordAndScaleProperty`** protocol
    - This allows for a single reusable `ChordCombinerTagsView` for both the `Letter` and `RootAccidental` pickers.
    - `ChordAndScaleProperty` is also used in `ChordCombinerPropertyMatcher` to highlight the `Letter`, `RootAccidental` and `ChordType` picker items to show matching properties.
  
  ##### Save On Select
  Every time the user selects a new property, the `chordPropertyData` property of `ChordCombinerViewModel` is updated and the `saveJSON` method stores the data.

### ChordCombinerSelectionMenu Screenshots

#### Initial screens for upper and lower chords:
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/lower%20chord%20menu%20initial%20screen.PNG" alt="Lower chord menu initial screen" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20initial%20screen.PNG" alt="Upper chord menu initial screen" width="341" height="694.5">

#### Lower chord menu, letter & accidental selected; Cma7 selected

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/lower%20chord%20menu%20letter%20and%20natural%20selected.PNG" alt="lower chord menu" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/lower%20chord%20menu%20-%20Cma7%20selected.PNG" alt="Cma7 selected" width="341" height="694.5">

#### Upper chord menu - Dma selected / only lower chord selected
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20-%20Dma%20selected%20no%20lower%20chord.PNG" alt="Upper chord menu, Dma selected" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20-%20lower%20chord%20selected.PNG" alt="only lower chord selected" width="341" height="694.5"> 

#### Upper chord menu - both chords selected: Dma / Dmi / Daug
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20-%20Dma%20selected.PNG" alt="Dma" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20-%20Dmi%20selected.PNG" alt="Dmi" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ee3c133c94c35d3b8f5ba4548654e6398e07aeee/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20-%20Daug%20selected.PNG" alt="Daug" width="341" height="694.5">