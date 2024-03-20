import 'package:flutter/material.dart';
import 'package:se_380/settings.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<StatefulWidget> createState() => BookmarkState();
}

class BookmarkState extends State<Bookmark> {
  List<Widget> bookmarks = List<Widget>.empty(growable: true);
  ScrollController? _scrollController;

  @override
  Widget build(BuildContext context) {
    _createBookmarkElements();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Bookmarks"),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) => bookmarks[index],
        controller: _scrollController,)
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  Future<void> _search() async {
    _scrollController?.jumpTo(0);
    setState(() {
    });
  }

  void _createBookmarkElements() {
    var urls = Settings().bookmarkUrls;
    for (String url in urls) {
      bookmarks.add(
          BookmarkElement(url: url)
      );
    }
  }
}

// TODO Consider expanding this class with extra fields.
// TODO Add dates
// TODO Save to disk
class BookmarkElement extends StatelessWidget {
  final String url;
  
  const BookmarkElement({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Text(url),
      ),
    );
  }
}