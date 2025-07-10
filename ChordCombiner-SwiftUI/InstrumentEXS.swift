import AudioKit
import AudioKitEX
import AudioKitUI
import AVFoundation
import Keyboard
import SoundpipeAudioKit
import SwiftUI
import Tonic

class InstrumentEXSConductor: ObservableObject, HasAudioEngine {
  let engine = AudioEngine()
  var instrument = AppleSampler()

  func noteOn(pitch: Pitch) {
    instrument.play(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), velocity: 90, channel: 0)
  }

  func noteOff(pitch: Pitch) {
    instrument.stop(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), channel: 0)
  }

  func notesOn(pitchNumbers: [Int]) {
    let pitches = pitchNumbers.map { Pitch(Int8($0)) }

    for pitch in pitches {
      instrument.play(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), velocity: 90, channel: 0)
    }
  }

  func notesOff(pitchNumbers: [Int]) {
    let pitches = pitchNumbers.map { Pitch(Int8($0)) }

    for pitch in pitches {
      instrument.stop(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), channel: 0)
    }
  }

  init() {
    engine.output = instrument

    // Load EXS file (you can also load SoundFonts and WAV files too using the AppleSampler Class)
    do {
      if let fileURL = Bundle.main.url(forResource: "Sounds/YDP-GrandPiano-20160804", withExtension: "sf2") {
        try instrument.loadMelodicSoundFont(url: fileURL, preset: 0)
      } else {
//        Log("Could not find file")
      }
    } catch {
//      Log("Could not load instrument")
    }
  }
}

struct PlayButton: View {
  @EnvironmentObject var conductor: InstrumentEXSConductor
  @EnvironmentObject var seqConductor: SFZSequencerConductor
  @Binding var isPlaying: Bool

  let pitches: [Int]
  var playOrStopImage: Image {
    isPlaying ? Image(systemName: "stop.circle") : Image(systemName: "play.circle")
  }

  init(isPlaying: Binding<Bool>, pitches: [Int]) {
    self._isPlaying = isPlaying
    self.pitches = pitches
  }

  var body: some View {
    Button {
      var duration: Duration = Duration(beats: 0)

      seqConductor.sequencer.clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))

      for (index, pitch) in pitches.enumerated() {
        seqConductor.sequencer.tracks[0].add(
          noteNumber: MIDINoteNumber(pitch),
          velocity: 80,
          position: Duration(beats: Double(index)),
          duration: Duration(beats: 1))
        duration += Duration(beats: 1)
      }
      seqConductor.playFromStart()
      isPlaying.toggle()
      print(duration.seconds)

      func turnOff() async {
        try? await Task.sleep(nanoseconds: UInt64(duration.seconds * 1_000_000_000))
      }

      Task {
        await turnOff()
        isPlaying = false
        seqConductor.sequencer.stop()
      }

//      if !isPlaying {
//        conductor.notesOn(pitchNumbers: pitches)
//      } else {
//        conductor.notesOff(pitchNumbers: pitches)
//      }
    } label: {
      playOrStopImage
        .foregroundStyle(.title)
        .onDisappear {
          if isPlaying {
            conductor.notesOff(pitchNumbers: pitches)
            isPlaying.toggle()
          }
        }
    }
  }

}
