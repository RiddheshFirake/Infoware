import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:infoware/models/news.dart'; // Replace with the actual path to your News model

class NewsDetailScreen extends StatelessWidget {
  final News article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title ?? 'News Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF003366),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.pop(context); // Pop to go back
          },
        ),
      ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image if available
              if (article.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    article.imageUrl!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 20.0),

              // Title of the article
              Text(
                article.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12.0),

              // Description of the article
              Text(
                article.description ?? 'No Description',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24.0),

              // Read Full Article Button
              ElevatedButton(
                onPressed: () async {
                  if (article.url != null) {
                    if (await canLaunchUrl(Uri.parse(article.url!))) {
                      await launchUrl(Uri.parse(article.url!));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent, // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Adjust horizontal padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(double.infinity, 50), // Ensure the button stretches to fit content
                ),
                child: const Text(
                  'Read Full Article',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                  textAlign: TextAlign.center, // Center the text inside the button
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
