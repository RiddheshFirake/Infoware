import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_player_event.dart';
import 'audio_player_state.dart';
import 'package:file_picker/file_picker.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  late AudioPlayer _audioPlayer;
  String? _filePath;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isShuffling = false;
  bool _isRepeating = false;

  AudioPlayerBloc() : super(AudioPlayerInitial()) {
    _audioPlayer = AudioPlayer();

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((position) {
      _position = position;
      if (state is AudioPlayerPlaying) {
        emit(AudioPlayerPlaying(
          filePath: _filePath!,
          position: _position,
          duration: _duration,
          songName: _getSongNameFromPath(_filePath!),
        ));
      }
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
      if (state is AudioPlayerPlaying) {
        emit(AudioPlayerPlaying(
          filePath: _filePath!,
          position: _position,
          duration: _duration,
          songName: _getSongNameFromPath(_filePath!),
        ));
      }
    });

    // Handle events
    on<PickFileEvent>(_handlePickFileEvent);
    on<PlayPauseEvent>(_handlePlayPauseEvent);
    on<SeekEvent>(_handleSeekEvent);
    on<ToggleShuffleEvent>(_handleToggleShuffleEvent);
    on<ToggleRepeatEvent>(_handleToggleRepeatEvent);
    on<PreviousTrackEvent>(_handlePreviousTrackEvent);
    on<NextTrackEvent>(_handleNextTrackEvent);
  }

  Future<void> _handlePickFileEvent(
      PickFileEvent event, Emitter<AudioPlayerState> emit) async {
    final filePath = await _pickFile();

    if (filePath != null) {
      _filePath = filePath;
      await _audioPlayer.setSource(UrlSource(filePath));

      emit(AudioPlayerFilePicked(
        filePath: filePath,
        position: _position,
        duration: _duration,
        songName: _getSongNameFromPath(filePath),
      ));
    } else {
      emit(AudioPlayerInitial());
    }
  }

  Future<void> _handlePlayPauseEvent(
      PlayPauseEvent event, Emitter<AudioPlayerState> emit) async {
    if (_filePath == null) return;

    if (state is AudioPlayerPaused || state is AudioPlayerFilePicked) {
      await _audioPlayer.play(UrlSource(_filePath!));
      emit(AudioPlayerPlaying(
        filePath: _filePath!,
        position: _position,
        duration: _duration,
        songName: _getSongNameFromPath(_filePath!),
      ));
    } else if (state is AudioPlayerPlaying) {
      await _audioPlayer.pause();
      emit(AudioPlayerPaused(
        filePath: _filePath!,
        position: _position,
        duration: _duration,
        songName: _getSongNameFromPath(_filePath!),
      ));
    }
  }

  Future<void> _handleSeekEvent(
      SeekEvent event, Emitter<AudioPlayerState> emit) async {
    await _audioPlayer.seek(event.position);
    emit(AudioPlayerPlaying(
      filePath: _filePath!,
      position: event.position,
      duration: _duration,
      songName: _getSongNameFromPath(_filePath!),
    ));
  }

  void _handleToggleShuffleEvent(
      ToggleShuffleEvent event, Emitter<AudioPlayerState> emit) {
    _isShuffling = !_isShuffling;
    emit(_isShuffling ? AudioPlayerShuffling() : AudioPlayerInitial());
  }

  void _handleToggleRepeatEvent(
      ToggleRepeatEvent event, Emitter<AudioPlayerState> emit) {
    _isRepeating = !_isRepeating;
    emit(_isRepeating ? AudioPlayerRepeating() : AudioPlayerInitial());
  }

  void _handlePreviousTrackEvent(
      PreviousTrackEvent event, Emitter<AudioPlayerState> emit) {
    // Implement logic for previous track
  }

  void _handleNextTrackEvent(
      NextTrackEvent event, Emitter<AudioPlayerState> emit) {
    // Implement logic for next track
  }

  Future<String?> _pickFile() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.audio);
    return result?.files.single.path;
  }

  String _getSongNameFromPath(String filePath) {
    return filePath.split('/').last;
  }
}
