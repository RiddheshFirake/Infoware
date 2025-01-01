// audio_player_event.dart

abstract class AudioPlayerEvent {}

class PlayPauseEvent extends AudioPlayerEvent {}

class SeekEvent extends AudioPlayerEvent {
  final Duration position;
  SeekEvent(this.position);
}

class PickFileEvent extends AudioPlayerEvent {}

class PreviousTrackEvent extends AudioPlayerEvent {}

class NextTrackEvent extends AudioPlayerEvent {}

class ToggleShuffleEvent extends AudioPlayerEvent {}

class ToggleRepeatEvent extends AudioPlayerEvent {}

// Existing events like PickFileEvent, PlayPauseEvent, etc.
