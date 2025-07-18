 # ChordCombiner

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/4c9f94b899bda454ddde198239e05e48797a76ad/ChordCombiner%20Light%20Mode%20Splash%20Icon%20large-keyboards%20%2B%3D%20v3.png" alt="Chord Combiner Light Mode" width="128" height="128">

## Central App Concept

Jazz piano-focused music theory & harmony app designed to help musicians recall and apply complex chords by breaking them down into smaller components. 

## Musical/Harmonic Background & Context

Chord theory and nomenclature can be a difficult concept for musicians to master, especially in a jazz context. The musician has to learn not only the names and locations of each note, but also their possible functions—known as **degrees**—in various chords, in every key. There are 12 unique pitches in Western music; 21 common note spellings—known as **keys**—for those 12 pitches (plus 14 more relative uncommon spellings, and still more rarely used spellings); and 21 different chord degree functions that each note can adopt in a chord, depending on the chord type and parent key. All of these elements result in a vast number of possible chord symbols, several of which involve as many as 6, 7, and in rare cases, 8 different notes, all with separate functions.

Because of the aforementioned complexity, remembering all the individual notes and degrees that make up a chord can be quite challenging; often, it can be easier to think of larger chords as a combination of smaller, simpler 3- and 4-note chords.

## Core Functionality

A chord calculator that combines the numeric degrees of two user-selected 3- or 4-note chords—a lower chord and an upper chord—and returns one of 3 results:

1. A **unified chord** *(single chord symbol with no alternate bass)*
2. A **slash chord** *(single chord symbol over an alternate bass)*
3. A **polychord** *(two chord symbols, one over the other)*

After selecting lower and upper chords, the user can view each chord's notes highlighted on separate piano keyboards, stacked in order of chord degree size, with the names of the notes displayed above the keyboard. They can also view the combined result on a 3rd keyboard, with each chords' notes highlighted in different colors. Circle glyphs are also displayed on the notes to show which chord each note belongs to.

After viewing the chords on the main page, the user can then navigate to detail pages with more information about the resulting chord or chords. Possible information displayed includes:

 - notes
 - degrees
 - component chords (lower & upper)
 - base chord, notes and degrees
 - extended notes
 - equivalent chords

For any chord listed in a detail view, the user can navigate further to another detail view in order to view information about that chord.

Finally, the user can tap a link in the detail page to view a mind map-style graph of all four-note chords, triads, and notes contained in the currently displayed chord.

There are Help links on every page in case the user is unclear on how to use the app.

### Primary structs & methods

#### Musical Building Blocks

**[Chords](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Chords/Chord.swift)** contain groups of **[Notes](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Notes/Note.swift)**. Each `Note` has a specific **[Degree](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Notes/Degree%20Enum/Degree.swift)** relative to its `Chord`, depending on the **[Root](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Protocols%20and%20Helpers/KeyName.RootKeyNote.swift)** and **[ChordType](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Chords/ChordType/ChordType.swift)** of the chord. The `Root` & `ChordType` make up the chord symbol that displays.

Every `Note` has a **[KeyName](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Protocols%20and%20Helpers/KeyName.swift)** that consists of a **[Letter](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Letter.swift)**, **[Accidental](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Accidental.swift)** (`RootAccidental`) and **[NoteNumber](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/60de77215f376a95ee82a36af0f19e68d2a7fe00/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/NoteNumber.swift)**. These elements make up the identity of the `Note`.

The same `Note` can be spelled with a different `KeyName` depending on other elements of its identity. For example, two notes can share the same `NoteNumber` of **`.three`**, but if one has a `Degree` of **`.minor3rd`** and the other has a `Degree` of **`.sharp9th`**, the first will display as **"E♭"**, while the second will display as **"D♯"**.

Another example: two `Note` objects both have a **`NoteNumber`** of **`.ten`** and a `Degree` of **`.major3rd`**; however, one's **`Accidental`** is **`.flat`** and the other's is **`.sharp`**. The first will display as **"B♭"** and the second will display as **"A♯"**.

**[Keyboards](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keyboard/Keyboard.swift)** are the main graphic display elements of the app; they consist of sets of **[Keys]()**. The **[KeyType](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/60de77215f376a95ee82a36af0f19e68d2a7fe00/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keys/Key%20ViewModels/KeyType.swift)** enum controls the **shape** (**[KeyShapeGroup](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/60de77215f376a95ee82a36af0f19e68d2a7fe00/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keys/KeyShape/KeyShapeGroup.swift)**, **[KeyShape](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/60de77215f376a95ee82a36af0f19e68d2a7fe00/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keys/KeyShape/KeyShape.swift)**, **[KeyShapePath](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/60de77215f376a95ee82a36af0f19e68d2a7fe00/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keys/KeyShape/KeyShapePath.swift)**), **color** and **position** of each `Key` within the `Keyboard`. **[KeyLetterView.swift](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/60de77215f376a95ee82a36af0f19e68d2a7fe00/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keys/KeySymbols%20Views/KeyLetterView.swift)** and **[KeyCirclesView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/60de77215f376a95ee82a36af0f19e68d2a7fe00/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keys/KeySymbols%20Views/KeyCirclesView.swift)** are responsible for displaying the letters above the notes & the circle glyphs on the notes themselves, respectively.

#### Primary Models

**[ChordCombinerViewModel](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerViewModel.swift)**, a **Singleton** class, is the main ViewModel for the app.

Data for other views is managed by the views themselves, if simple enough, or by separate models and/or view models for those specific views.

**[Chord Combiner](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerModels/ChordCombiner.swift)** is the struct that determines the results of the primary chord calculator function of the app.

**[Voicing Calculator](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Chords/VoicingCalculator.swift)** & **[ChordCombinerVoicingCalculator.swift](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerModels/ChordCombinerVoicingCalculator.swift)** determine which notes to display on the main display keyboards.

**[KeyboardHighlighter](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Keyboard%20and%20Keys%20Views/Keyboard/Keyboard%20Models/KeyboardHighlighter.swift)** contains all the methods to highlight the notes that the voicing calculators select.

**[ImageService](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/b4d15388973c6f9c718785649940f6990e162207/ChordCombiner-SwiftUI/ChordGrapher%20Views/ChordGrapher%20Network%20Model/ImageService.swift)** manages the network call to the image-charts.com API to produce the chord graphs. **[ChordGrapher](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/b4d15388973c6f9c718785649940f6990e162207/ChordCombiner-SwiftUI/ChordGrapher%20Views/ChordGrapher%20Models/ChordGrapher.swift)** is the main model for the chord graphs themselves, and also produces the `URL` to send to `ImageService`.

## iOS & Swift Concepts Used

### Intro to Swift
The app uses many of the foundational elements of Swift from the **Introduction to Swift** & **Programming in Swift: Fundamentals** modules:

- Primitive data types
  - `Int`
  - `Double`
  - `String`
  - `Bool`
- Primary collection types
  - `Array`
  - `Set`
  - `Dictionary`
- Other Data Types, Objects & Concepts from Foundation
  - `Optionals`
  - `Logical Operators`
  - `UUID`
  - `CGFloat`
  - `CGSize`
  - `CGPoint`
  - `UIImage`
  - `closed and half-open ranges`
  - `closure`
  - `typealias  `

- Custom Named data types
  - `Struct`
  - `Class`
  - `Enum`

The app utilizes the built-in methods of these basic types, as well as **extensions** on basic and custom data types whenever possible, to allow for code reuse.

Most of the internal logic of the app is based on `switch` statements iterating over `enum` cases; `Array`, `Set` & `Dictionary` operations on various collections; and failable initializers in the `Chord` struct and `ChordType` enum.

### SwiftUI

The app uses many elements from the **Getting Started with SwiftUI** modules, as well as applicable modifiers:

- `View`
- `ViewBuilder`
- `ViewModifier`
- `HStack, VStack, ZStack`
- `Group`
- `Divider`
- `Spacer`
- `Button`
- `Text`
- `TabView`
- `ToolBar`
- `ToolbarItem`
- `Sheet`
- `Form`
- `Section`
- `List`
- `ForEach`
- `Color`
- `Image`
- `Font`
- `Shape`
  - `Circle`
  - `Rectangle`
  - `RoundedRectangle`
- `ShapeStyle`
- `Path`
- `GeometryReader`
- `NavigationStack`
- `NavigationLink`
- `ScrollView`
- `ScrollViewReader`
- `ProgressView`

The app uses composition and reusable views and view modifiers wherever possible to avoid unnecessary code duplication.

### Flow Control & Functions

The app uses the following methods of flow control:

- `if-else`
- `if-else-if-else`
- `if-let`
- `case let`
- `guard` & `guard-let`
- `for-in`
- `while`
- `switch`
- `ternary operator`
- `enumerated()`

`where`, `is` and `as?` clauses are used when necessary to specify additional conditions

### Data Passing _(Sharing & State Management in SwiftUI; Passing Data in SwiftUI)_

The app uses `@State`, @`Binding`, `@Bindable`, `@Observable` & `@Environment` to pass data around, as well as standard `let` and `var` properties when 2-way communication isn't necessary.

Most custom objects in the app primarily use stored properties with property observers rather than computed properties to minimize unnecessary recalculations of heavily used properties, but computed variables are used 

### Layout

The app mostly uses standard layout methods like stack views with alignment and spacing parameters; `Spacer()`; and `.position` & ``offset` modifiers.

To accomodate different color schemes, the app uses custom Color Assets and modifiers.

To accommodate different screen sizes, the app uses `GeometryReader` to set the width of the main keyboards to a percentage of the available screen width.

### Navigation _(SwiftUI Navigation)_

The app uses `NavigationStack` and `NavigationLink` for its primary navigation elements.

The Help links use modal views presented with `sheet(isPresented:onDismiss:content:)`, as well as a nested `TabView` in `SelectionMenuHelpView`. 

### Protocols & Generics _(Applying Protocol-Oriented Programming in Development)_

The app uses protocols throughout to enforce conformance for custom types, to allow for easy addition of future functionalities, and for composition. The app uses the [ChordAndScaleProperty](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/fc43a22380e6dd5e64bddc1f146b23cebee8d6a1/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Protocols%20and%20Helpers/ChordAndScaleProperty.swift) protocol combined with generics to facilitate reusuable views and functions for different types of data.

**`Letter`**, **`RootAccidental`** and **`ChordType`** conform to the **`ChordAndScaleProperty`** protocol. This allows for a single reusable **`ChordCombinerTagsView`** for both the `Letter` and `RootAccidental` pickers in the **`ChordCombinerSelectionMenu`**

**`ChordAndScaleProperty`** is also used in **`ChordCombinerPropertyMatcher`** to highlight the `Letter`, `RootAccidental` and `ChordType` picker items to show matching properties.

### Data Persistence _(Data Persistence in SwiftUI)_

`ChordCombinerViewModel` uses **JSON** to store and load the [ChordPropertyData](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordProperties/ChordPropertiesModels/ChordPropertyData.swift) selections (a struct containing optional [Letter](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Letter.swift), [RootAccidental](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Notes/Note%20Enums/Accidental.swift) and [ChordType](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/ef4fe463358016083f9eb82e8d9f1aa809316ed0/ChordCombiner-SwiftUI/Global%20Models/Chords/ChordType/ChordType.swift) properties). This JSON data is loaded when `ChordCombinerView` appears; if no JSON file is found, the `loadJSON` method sets all `ChordPropertyData` properties to `nil` and the app presents the intial launch state.

In `ChordCombinerPropertySelectionView`, every time the user selects a new property, the `chordPropertyData` property of `ChordCombinerViewModel` is updated and the `saveJSON` method stores the data.

### Networking & Concurrency _(Networking & Concurrency in SwiftUI)_

#### Networking

The app uses the following networking concepts:

- `URLSession`
- `URLComponents`
- `HTTPURLResponse`
- `URLQueryItem`
- `Data`
- `statusCode`
- error handling with `guard let` statements

#### Concurrency

The app uses concurrency via `try await` & `for try await` statements in `ChordGraphImageView` & `ImageService`  to ensure that the network calls don't lock up the main UI.

It also uses `DispatchQueue.concurrentPerform(iterations:)` in `Chord`: `containingChords()` and `Array Extensions`: `filterInChordsContainingNoChords()` to speed up those particularly computationally heavy methods. `Task` and `await` are used any time objects that use these methods are created.

### API

The mind-map graph uses data from the [image-charts](http://image-charts.com) API, using [graphviz dot language](https://graphviz.org/doc/info/lang.html) to build the URL.

## Screenshots

### Initial Screen: [ChordCombinerView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/e72cc3202da023e8beeb25876318e258caf6e540/ChordCombiner-SwiftUI/ChordCombinerView.swift)

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/Initial_View.png" alt="Initial Screen" width="341" height="694.5">

The below screenshots show the different outcomes for `ChordCombinerView`:

#### Lower chord selected / Upper Chord selected
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/ChordCombinerView_LowerChordSelected.png" alt="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/ChordCombinerView_LowerChordSelected.png" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/ChordCombinerView_UpperChordSelected.png" alt="ChordCombinerView - Upper chord selected" width="341" height="694.5">

#### Both chords selected - Combined, slash and polychord results

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/ChordCombinerView_Cma13_sh11.png" alt="ChordCombinerView - Both chords selected, combined chord" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/ChordCombinerView_SlashChord.png" alt="ChordCombinerView - Both chords selected, slash chord" width="341" height="694.5"> 
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/ChordCombinerView_Polychord.png" alt="ChordCombinerView - Both chords selected, polychord" width="341" height="694.5">

## [ChordCombinerChordSelectionMenu](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/c050522459a11841f6656c9561bd946cb27c83b6/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerChordSelectionMenu.swift)

### Functionality
The user can tap on any letter, accidental or ChordType in [ChordCombinerPropertySelectionView](https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/cc31ea3f73093f07bfde58a7834a33fa93a48536/ChordCombiner-SwiftUI/ChordCombinerView/ChordCombinerMenu%20Views/ChordCombinerPropertySelectionView.swift) to select it; that chord property will then become highlighted.

- Once the user has selected all 3 chord properties (Letter, Accidental & ChordType), the keyboards in the ChordType list highlight with chords in the selected `RootKeyNote`, and the keyboard titles update to match.
- Once the user selects both a **Lower** and an **Upper** chord, the `ChordAndScaleProperty` tags light up based on matches to the chord not currently being selected.

ChordType `Keyboards` light up similarly, with the following differences:
  - Only the chord symbol changes color, and does not glow (for readability purposes)
  - Instead, the `Keyboard` displays a glow if it matches
  - The chord symbol changes color based on if the chord matches or is selected.
  - Additionally, a text label stating **"match found!"** appears to the right of the keyboard tag if a `ChordType` matches.

#### `ChordCombinerPropertySelectionView`
  - A horizontal row with custom `Letter` and Accidental (`RootAccidental`) pickers (`ChordCombinerTagsView`).
    - in the Accidental picker, the &#x266E; sign is pre-selected for convience
  - A vertical List with keyboards for every triad and simple 4-note `ChordType`, initially displaying the title of the `ChordType` with no Letter or Accidental prefix
    - once a ChordType is selected, the List automatically scrolls to that `ChordType` position if the user leaves the selection screen and comes back later.

### ChordCombinerSelectionMenu Screenshots

#### Initial screens for lower and upper chords:

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/LowerChordMenu_InitialView.png" alt="Lower chord menu initial screen" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/UpperChordMenu_InitialView.png" alt="Upper chord menu initial screen" width="341" height="694.5">

#### Lower chord menu, letter & accidental selected; Cma selected

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/LowerChordMenu_LetterAccidentalSelected.png" alt="lower chord menu - letter & accidental selected" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/LowerChordMenu_CMaSelected.png" alt="Cma selected" width="341" height="694.5">

#### Upper chord menu - letter & accidental selected / Dma selected / only lower chord selected

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/UpperChordMenu_LetterAccidentalSelected.png" alt="Upper chord menu, Letter & Accidental selected" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/UpperChordMenu_DmaSelected.png" alt="Upper chord menu, Dma selected" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/UpperChordMenu_LowerChordSelected.png" alt="only lower chord selected" width="341" height="694.5"> 

#### Upper chord menu - both chords selected: Dma / Dmi / Daug
<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/UpperChordMenu_Cma13_sh11.png" alt="Dma" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/UpperChordMenu_SlashChord.png" alt="Dmi" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/UpperChordMenu_Polychord.png" alt="Daug" width="341" height="694.5">

### DetailView Screenshots

#### DualChordDetailView - Cma13(♯11) page 1 / page 2

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/DetailView_Cma13_sh11_p1.png" alt="Detail Cma13(♯11) page 1" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/DetailView_Cma13_sh11_p2.png" alt="Detail Cma13(♯11) page 2" width="341" height="694.5">

#### DualChordDetailView - Cma9

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/DetailView_Cma9.png" alt="Detail Cma9" width="341" height="694.5">

#### SingleChordDetailView - Cma7 / Emi(♭6)

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/DetailView_Cma7.png" alt="Detail Cma7" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/DetailView_Emi_b6.png" alt="Detail Emi(♭6)" width="341" height="694.5">

### GraphView Screenshots

#### GraphView - Cma13(♯11) wide / zoomed

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/GraphView_Cma13_sh11_wide.png" alt="Graph Cma13(♯11) wide" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/GraphView_Cma13_sh11_zoomed.png" alt="Graph Cma13(♯11) zoomed" width="341" height="694.5">

#### GraphView - Cma9 / Cma7

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/GraphView_Cma9.png" alt="Graph Cma9" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/GraphView_Cma7.png" alt="Graph Cma7" width="341" height="694.5">

#### GraphView - Cma7(♭5) / Cma

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/GraphView_Cma7_b5.png" alt="Graph Cma7(♭5)" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/GraphView_Cma.png" alt="Graph Cma" width="341" height="694.5">

### HelpView Screenshots

#### HelpView - InitialHelpView

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/HelpView_Initial.png" alt="HelpView Initial" width="341" height="694.5">

#### HelpView - DualChordHelpView

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/HelpView_%20DualChordSymbolsLegend.png" alt="HelpView Dual" width="341" height="694.5">

#### HelpView - SelectionMenuHelpView - Letter / Accidental / ChordType Pickers

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/HelpView_LetterPicker.png" alt="HelpView Letter" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/HelpView_AccidentalPicker.png" alt="HelpView Accidental" width="341" height="694.5"> <img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/HelpView_ChordTypePicker.png" alt="HelpView ChordType" width="341" height="694.5">

#### HelpView - GraphViewHelpView

<img src="https://github.com/thewildjacko/ChordCombiner-SwiftUI/blob/main/ChordCombiner-SwiftUI/Screenshots/New/HelpView_GraphView.png" alt="HelpView GraphView" width="341" height="694.5">

