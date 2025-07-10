//
//  SequencerTest.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/6/25.
//

// Copyright AudioKit. All Rights Reserved.

import AudioKit
import AudioKitEX
import AudioKitUI
import AVFoundation
import Combine
import SwiftUI
import DunneAudioKit
import SoundpipeAudioKit

class SFZSequencerConductor: ObservableObject, HasAudioEngine {
  let engine = AudioEngine()
  var instrument = AppleSampler()
  var midiCallback = MIDICallbackInstrument()
  let sequencer = AppleSequencer(fromURL: Bundle.main.url(forResource: "Sounds/4tracks", withExtension: "mid")!)

  @Published var tempo: Float = 120 {
    didSet {
      sequencer.setTempo(BPM(tempo))
    }
  }

  @Published var isPlaying = false {
    didSet {
      isPlaying ? playFromStart() : sequencer.stop()
    }
  }

  func playFromStart() {
    sequencer.rewind()
    sequencer.play()
  }

  init() {
    midiCallback.callback = { status, note, velocity in
      if status == 144 { // Note On
        self.instrument.play(noteNumber: note, velocity: velocity, channel: 0)
      } else if status == 128 { // Note Off
        self.instrument.stop(noteNumber: note, channel: 0)
      }
    }

    do {
      // Load SFZ file with Dunne Sampler.
      // This needs to be loaded after a delay the first time
      // to get the correct Settings.sampleRate if it is 48_000.
      if let fileURL = Bundle.main.url(forResource: "Sounds/YDP-GrandPiano-20160804", withExtension: "sf2") {
        print("loading!")
        try self.instrument.loadMelodicSoundFont(url: fileURL, preset: 0)
      } else {
        Log("Could not find file")
      }

    } catch {
      Log("Could not find file")
    }
    self.instrument.volume = 1
    engine.output = instrument

    try? engine.start()

    sequencer.clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
    sequencer.debug()
    sequencer.setGlobalMIDIOutput(midiCallback.midiIn)
//    sequencer.enableLooping(Duration(beats: 8))
    sequencer.setTempo(60)

//    sequencer.tracks[0].add(noteNumber: 60, velocity: 80, position: Duration(beats: 1), duration: Duration(beats: 0.5))
//    sequencer.tracks[0].add(noteNumber: 63, velocity: 80, position: Duration(beats: 2), duration: Duration(beats: 0.5))
//    sequencer.tracks[0].add(noteNumber: 65, velocity: 80, position: Duration(beats: 3), duration: Duration(beats: 0.5))
//    sequencer.tracks[0].add(noteNumber: 62, velocity: 80, position: Duration(beats: 4.5), duration: Duration(beats: 0.5))
//    sequencer.tracks[0].add(noteNumber: 65, velocity: 80, position: Duration(beats: 5.5), duration: Duration(beats: 0.5))
//    sequencer.tracks[0].add(noteNumber: 67, velocity: 80, position: Duration(beats: 6.5), duration: Duration(beats: 0.5))
//    sequencer.tracks[0].add(noteNumber: 71, velocity: 80, position: Duration(beats: 7), duration: Duration(beats: 1))
//    sequencer.tracks[0].add(noteNumber: 72, velocity: 80, position: Duration(beats: 8), duration: Duration(beats: 1))
//    sequencer.tracks[0].add(noteNumber: 60, velocity: 80, position: Duration(beats: 9), duration: Duration(beats: 4))
//    sequencer.tracks[0].add(noteNumber: 64, velocity: 80, position: Duration(beats: 9), duration: Duration(beats: 4))
//    sequencer.tracks[0].add(noteNumber: 67, velocity: 80, position: Duration(beats: 9), duration: Duration(beats: 4))
//    sequencer.tracks[0].add(noteNumber: 72, velocity: 80, position: Duration(beats: 9), duration: Duration(beats: 4))
  }
}

struct SFZSequencerView: View {
  @StateObject var conductor = SFZSequencerConductor()
  @State private var isEditing = false
  @State private var isEditingVolume = false

  func recalibrate() {
    conductor.sequencer.clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
//    conductor.sequencer.debug()
//    conductor.sequencer.setGlobalMIDIOutput(conductor.midiCallback.midiIn)
//    conductor.sequencer.enableLooping(Duration(beats: 7))
//    conductor.sequencer.setTempo(250)

    conductor.sequencer.tracks[0].add(noteNumber: 60, velocity: 80, position: Duration(beats: 1), duration: Duration(beats: 0.5))
    conductor.sequencer.tracks[0].add(noteNumber: 63, velocity: 80, position: Duration(beats: 2), duration: Duration(beats: 0.5))
    conductor.sequencer.tracks[0].add(noteNumber: 65, velocity: 80, position: Duration(beats: 3), duration: Duration(beats: 0.5))
    conductor.sequencer.tracks[0].add(noteNumber: 62, velocity: 80, position: Duration(beats: 4.5), duration: Duration(beats: 0.5))
    conductor.sequencer.tracks[0].add(noteNumber: 65, velocity: 80, position: Duration(beats: 5.5), duration: Duration(beats: 0.5))
    conductor.sequencer.tracks[0].add(noteNumber: 70, velocity: 80, position: Duration(beats: 6.5), duration: Duration(beats: 0.5))
  }
  var body: some View {
    VStack(spacing: 10) {
      Spacer()
      Text(conductor.isPlaying ? "Stop" : "Start")
        .foregroundColor(.blue)
        .onTapGesture {
          conductor.isPlaying.toggle()
        }
      Slider(value: $conductor.tempo, in: 60...400, step: 1) {
        Text("Tempo")
      } minimumValueLabel: {
        Text("60")
      } maximumValueLabel: {
        Text("400")
      } onEditingChanged: { editing in
        isEditing = editing
      }
      Text("\(conductor.tempo)")
        .foregroundStyle(isEditing ? .red : .blue)

      Text("recalibrate")
        .onTapGesture {
          recalibrate()
        }

      Slider(value: $conductor.instrument.amplitude, in: -90...12, step: 0.1) {
        Text("Volume")
      } minimumValueLabel: {
        Text("0")
      } maximumValueLabel: {
        Text("1")
      } onEditingChanged: { editing in
        isEditingVolume = editing
      }
      Text("\($conductor.instrument.amplitude)")
        .foregroundStyle(isEditingVolume ? .red : .blue)

      Spacer()
    }
    .onAppear {
      conductor.start()
    }
    .onDisappear {
      conductor.isPlaying = false
      conductor.sequencer.stop()
      conductor.engine.stop()
      conductor.stop()
    }
  }
}
