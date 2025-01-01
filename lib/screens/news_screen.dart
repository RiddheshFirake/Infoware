import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/blocs/news_bloc.dart';
import 'package:infoware/blocs/news_event.dart';
import 'package:infoware/screens/audio_player_screen.dart';
import 'package:infoware/screens/news_details_screen.dart'; // Import the detailed screen
import 'package:url_launcher/url_launcher.dart';
import 'package:infoware/screens/form_screen.dart'; // Import your form screen here

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<NewsBloc>(context).add(FetchNewsEvent());
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        BlocProvider.of<NewsBloc>(context)
            .add(SearchNewsEvent(_searchController.text));
      } else {
        BlocProvider.of<NewsBloc>(context).add(FetchNewsEvent());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search news...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
          cursorColor: Colors.white,
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'News App',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF003366),
        elevation: 8.0,
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isSearching ? Icons.close : Icons.search,
                key: ValueKey<bool>(_isSearching),
                color: Colors.white,
                size: 28.0,
              ),
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                  BlocProvider.of<NewsBloc>(context).add(FetchNewsEvent());
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final newsItem = state.news[index];
                return Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            newsItem.imageUrl.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                newsItem.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Icon(
                                Icons.image,
                                color: Colors.grey[600],
                                size: 30.0,
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newsItem.title,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    newsItem.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsDetailScreen(article: newsItem),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              child: Text(
                                'Show Full Article',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (await canLaunchUrl(
                                    Uri.parse(newsItem.url))) {
                                  await launchUrl(Uri.parse(newsItem.url));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              child: Text(
                                'Open in Chrome',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is NewsError) {
            return const Center(
                child: Text('Failed to load news',
                    style: TextStyle(color: Colors.red)));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AudioPlayerScreen()),
              );
            },
            child: Icon(Icons.music_note),
            backgroundColor: Colors.blueAccent,
            tooltip: 'Audio Player',
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserFormPage()),
              );
            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.green,
            tooltip: 'User Form',
          ),
        ],
      ),
    );
  }
}
