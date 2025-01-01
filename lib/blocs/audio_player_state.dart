abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerFilePicked extends AudioPlayerState {
  final String filePath;
  final Duration position;
  final Duration duration;
  final String songName;

  AudioPlayerFilePicked({
    required this.filePath,
    required this.position,
    required this.duration,
    required this.songName,
  });
}

class AudioPlayerPlaying extends AudioPlayerState {
  final String filePath;
  final Duration position;
  final Duration duration;
  final String songName;

  AudioPlayerPlaying({
    required this.filePath,
    required this.position,
    required this.duration,
    required this.songName,
  });
}

class AudioPlayerPaused extends AudioPlayerState {
  final String filePath;
  final Duration position;
  final Duration duration;
  final String songName;

  AudioPlayerPaused({
    required this.filePath,
    required this.position,
    required this.duration,
    required this.songName,
  });
}

class AudioPlayerShuffling extends AudioPlayerState {}

class AudioPlayerRepeating extends AudioPlayerState {}
