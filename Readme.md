Cue Notes
---------

Plugin for MuseScore to turn chords and rests in a selected region into "cue" notes - small, with playback velocity (volume) set to 0 (actually set to 1, very silent, to keep the playback cursor moving though the selection rather than jumping over it) resp. with play mode set to off (for 2.0)
This plugin actually toggles the the values for 'small' (and 'play' in 2.0, but but not the 'velocity' in 1.x), so running it twice against the same selection reverts the settings if the first run (except the velocity setting in 1.x).
