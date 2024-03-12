import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  final String title;
  final String description;
  final String url;

  const NewsWidget({super.key,
    required this.title,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.indigo.shade50,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(description)),
            Align(
                alignment: Alignment.topLeft,
                child: Text(url)),
          ],
        ),
      ),
    );
  }
}

/// This class converts news JSON data to an object.
/// https://docs.flutter.dev/cookbook/networking/fetch-data
///
class News {
  final String title;
  final String description;
  final String url;

  const News({
    required this.title,
    required this.description,
    required this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'title': String title,
      'description': String description,
      'url': String url,
      } => News (
        title: title,
        description: description,
        url: url,
      ),
      _ => throw const FormatException("Failed to load news."),
    };
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write("$title\n");
    buffer.write("$description\n");
    buffer.write("$url\n\n");
    return buffer.toString();
  }
}