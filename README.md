# Chord Combiner

![Chord Combiner Light Mode 128px](ChordCombiner%20Light%20Mode%20Splash%20Icon%20large-keyboards%20%2B%3D%20v3%20128px.jpg)

Piano-focused music theory & harmony app designed to help musicians learn about the connections between different chords. The core functionality is a chord calculator.

[View Navigation Map](https://app.thebrain.com/brain/2386d191-7ecd-4581-8c39-9b8a5e16722f/b317b021-f918-4cb2-a72f-7da1aa422953)

## Initial Screen: [ChordCombinerView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/ChordCombinerView.swift)

![Initial Screen](ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20initial%20screen.PNG)

This is the main view of the app. It displays 3 `Keyboard` views, initially with no keys highlighted.

The user can tap either the upper or lower keyboards or their titles, displayed with [ChordCombinerMenuCoverView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/86f06c6e1e2b459d056f4d0d313565524b2905dc/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerMenuCoverView.swift), to move on to the next screen, [ChordCombinerChordSelectionMenu](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c050522459a11841f6656c9561bd946cb27c83b6/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerChordSelectionMenu.swift).

After users have selected lower and/or upper keyboards, they can return to [ChordCombinerView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/ChordCombinerView.swift) to see a visual overview of their selections. The below screenshots show the different outcomes for `ChordCombinerView`:

#### Lower chord selected / Upper Chord selected

![ChordCombinerView - Lower chord selected](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20lower%20chord%20selected.jpeg) ![ChordCombinerView - Upper chord selected](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20upper%20chord%20selected.PNG)

#### Both chords selected - Combined, slash and split chord results

![ChordCombinerView - Both chords selected, combined chord](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20combined%20chord%20view.PNG) ![ChordCombinerView - Both chords selected, slash chord](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20slash%20chord%20view.PNG) ![ChordCombinerView - Both chords selected, split chord](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/Screenshots/ChordCombinerView%20-%20split%20chord%20view.PNG)

The `ChordCombinerKeyboards` are managed by an `@Observable` and `@Bindable` **[ChordCombinerViewModel](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c7c78c4e8dcec283ece306f90bde7dbb2dc14aa5/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerViewModel.swift)** singleton, which also contains 3 optional `Chord` objects:

- `lowerChord`
  - displays on `lowerKeyboard`, and also on `combinedKeyboard` if only `lowerChord` is selected
- `upperChord
  - displays on `upperKeyboard`, and also on `combinedKeyboard` if only `upperChord` is selected
- `resultChord`
  - displays on `combinedKeyboard`, if a `Chord` match exists, once both `lowerChord` and `upperChord` are selected.

These three Chord objects control what notes are highlighted on each of the 3 main keyboards, and also which data to display for [DualChordDetailView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c7c78c4e8dcec283ece306f90bde7dbb2dc14aa5/ChordCombiner-SwiftUI/DualChordViews/DualChordDetailView.swift).

### Data Persistance

`ChordCombinerViewModel` uses JSON to store and load the [ChordPropertyData](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordProperties/ChordPropertiesModels/ChordPropertyData.swift) selections (a struct containing optional [Letter](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Letter.swift), [RootAccidental](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Accidental.swift) and [ChordType](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Chords/ChordType/ChordType.swift) properties). This JSON data is loaded when `ChordCombinerView` appears; if no JSON file is found, the `loadJSON` method sets all `ChordPropertyData` properties to `nil` and the app presents the intial launch state.

## [User Interaction - ChordCombinerChordSelectionMenu](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c050522459a11841f6656c9561bd946cb27c83b6/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerChordSelectionMenu.swift)

#### Initial Screen (upper and lower chords):

![Lower chord menu initial screen](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Screenshots/lower%20chord%20menu%20initial%20screen.PNG) ![Upper chord menu initial screen](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20initial%20screen.PNG)

#### Lower chord menu, letter & accidental selected; Cma7 selected; Upper chord menu, Dma selected

![lower chord menu](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/bfb6292a790aef55189fcad3458ca8ba4ca880fe/ChordCombiner-SwiftUI/Screenshots/lower%20chord%20menu%20letter%20and%20natural%20selected.PNG) ![Cma7 selected](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/bfb6292a790aef55189fcad3458ca8ba4ca880fe/ChordCombiner-SwiftUI/Screenshots/lower%20chord%20menu%20-%20Cma7%20selected.PNG) ![Upper chord menu, Dma selected](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/bfb6292a790aef55189fcad3458ca8ba4ca880fe/ChordCombiner-SwiftUI/Screenshots/upper%20chord%20menu%20-%20Dma%20selected%20no%20lower%20chord.PNG)

#### 

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
  - ChordType `Keyboards` light up similarly, with the following differences:
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


   
- A 2-octave **Upper Keyboard** (`ChordCombinerMenuCoverView`)
  - Initial title: "Select Upper Chord"
  - Navigation link: "Please select a chord"  + the Keyboard itself
- A 3-octave **Combined keyboard** `DualChordKeyboardView`
  - Initial title: "waiting for chord selection..."
