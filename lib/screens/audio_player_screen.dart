import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/blocs/audio_player_bloc.dart';
import 'package:infoware/blocs/audio_player_event.dart';
import 'package:infoware/blocs/audio_player_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', // Use the Poppins font
      ),
      home: BlocProvider(
        create: (context) => AudioPlayerBloc(),
        child: AudioPlayerScreen(),
      ),
    );
  }
}

class AudioPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Audio Player', // AppBar Title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent, // Transparent background for AppBar
        elevation: 0, // No shadow
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.pop(context); // Pop to go back
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white), // Settings icon
            onPressed: () {
              // Implement settings logic if needed
            },
          ),
        ],
      ),
      body: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          String songName = (state is AudioPlayerPlaying || state is AudioPlayerPaused)
              ? (state as dynamic).songName
              : 'No Track Selected';

          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/concert_background.jpg',
                  fit: BoxFit.cover, // Ensures the image covers the screen without distortion
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              // Main UI
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    // Song Info
                    Text(
                      songName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Liberia&Co.', // Replace with your artist info
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Slider for Audio Progress
                    Slider(
                      value: (state is AudioPlayerPlaying || state is AudioPlayerPaused)
                          ? (state as dynamic).position.inSeconds.toDouble()
                          : 0.0,
                      min: 0.0,
                      max: (state is AudioPlayerPlaying || state is AudioPlayerPaused)
                          ? (state as dynamic).duration.inSeconds.toDouble()
                          : 100.0,
                      onChanged: (value) {
                        if (state is AudioPlayerPlaying || state is AudioPlayerPaused) {
                          BlocProvider.of<AudioPlayerBloc>(context).add(
                            SeekEvent(Duration(seconds: value.toInt())),
                          );
                        }
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                    // Playback Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AudioPlayerBloc>(context)
                                .add(ToggleShuffleEvent());
                          },
                          icon: Icon(
                            Icons.shuffle,
                            color: state is AudioPlayerShuffling
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AudioPlayerBloc>(context)
                                .add(PreviousTrackEvent());
                          },
                          icon: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AudioPlayerBloc>(context)
                                .add(PlayPauseEvent());
                          },
                          icon: Icon(
                            state is AudioPlayerPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AudioPlayerBloc>(context)
                                .add(NextTrackEvent());
                          },
                          icon: Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AudioPlayerBloc>(context)
                                .add(ToggleRepeatEvent());
                          },
                          icon: Icon(
                            Icons.repeat,
                            color: state is AudioPlayerRepeating
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Pick File Button
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AudioPlayerBloc>(context)
                            .add(PickFileEvent());
                      },
                      child: Text(
                        "Pick an Audio File",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, // Make text bold
                          fontSize: 16, // Slightly larger font size for better visibility
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Larger padding for more prominent button
                        primary: Colors.transparent, // Transparent background for custom gradient
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // More rounded corners
                        ),
                        side: BorderSide(color: Colors.white.withOpacity(0.6), width: 2), // Subtle white border
                        elevation: 5, // Slight shadow for depth
                      ).copyWith(
                        shadowColor: MaterialStateProperty.all(Colors.blueAccent.withOpacity(0.6)), // Custom shadow color
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
