import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/blocs/news_bloc.dart';
import 'package:infoware/screens/news_screen.dart';
import 'package:infoware/repositories/news_repository.dart';
import 'package:infoware/blocs/audio_player_bloc.dart'; // Import the AudioPlayerBloc
import 'package:infoware/screens/audio_player_screen.dart'; // Import the AudioPlayerScreen

void main() {
  final NewsRepository newsRepository = NewsRepository(
    apiUrl: 'https://newsapi.org/v2/top-headlines',
    apiKey: 'f452e9c8f26749198359f5e0b56e3f32', // Replace with your actual API key
  );

  runApp(MyApp(newsRepository: newsRepository));
}

class MyApp extends StatelessWidget {
  final NewsRepository newsRepository;

  MyApp({required this.newsRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Providing the NewsBloc
        BlocProvider(
          create: (context) => NewsBloc(newsRepository: newsRepository),
        ),
        // Providing the AudioPlayerBloc
        BlocProvider(
          create: (context) => AudioPlayerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'News & Audio Player App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins', // Ensures your app uses the Poppins font
        ),
        home: NewsScreen(), // Home screen showing news, or you can set to AudioPlayerScreen
      ),
    );
  }
}
