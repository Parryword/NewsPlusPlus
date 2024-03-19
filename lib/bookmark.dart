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
    // TODO: implement build
    return ListView.builder(
      itemCount: bookmarks.length,
      itemBuilder: (context, index) => bookmarks[index],
      controller: _scrollController,);
  }

  Future<void> _search() async {
    _scrollController?.jumpTo(0);
    setState(() {
    });
  }

  void _createBookmarkWidget() {
    var urls = Settings().bookmarkUrls;
    for (String url in urls) {
      bookmarks.add(
          Container(
            color: Theme.of(context).colorScheme.inversePrimary,
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
}