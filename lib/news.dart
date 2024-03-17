import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'network.dart';

class NewsWidget extends StatefulWidget {
  final String title;
  final String description;
  final String url;

  const NewsWidget({
    super.key,
    required this.title,
    required this.description,
    required this.url,
  });

  @override
  State<StatefulWidget> createState() => _NewsState();
}

/// "Proto Coders Point" https://www.youtube.com/watch?v=XHroTEqZJb8
class _NewsState extends State<NewsWidget> {
  var _tapPosition = Offset.zero;
  void _getTabPosition(TapDownDetails details) {
    setState(() {
      _tapPosition = details.globalPosition;
      debugPrint(_tapPosition.toString());
    });
  }

  Future<void> _showContextMenu(context) async {
    final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();
    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
          Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 10, 10),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width, overlay!.paintBounds.size.height)
        ),
        items: [
          const PopupMenuItem(child: Text("Bookmark"),),
          PopupMenuItem(child: const Text("Copy link"), onTap: () async {
            await Clipboard.setData( ClipboardData(text: widget.url.toString()));
          },),
          PopupMenuItem(child: const Text("Open"), onTap: () {BrowserView(url: widget.url).launch();},),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTapDown: (position) {
          _getTabPosition(position);
        },
        onLongPress: (){
          _showContextMenu(context);
        },
        child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.indigo.shade50,
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    BrowserView(url: widget.url).launch();
                  },
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(widget.description.replaceAll("\n", ""))),
                      Align(alignment: Alignment.topLeft, child: Text(widget.url)),
                    ],
                  ),
                ),
              ],
            )
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
      } =>
        News(
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
