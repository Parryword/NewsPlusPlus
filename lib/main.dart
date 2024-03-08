import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Plus Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo.shade900),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'News Plus Plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mainText = "Home";
  String searchText = "Turkey";

  Future<void> _search() async {
    final response = await get(Uri.parse("https://newsapi.org/v2/everything?q=$searchText&apiKey=1d03b991a18c4c62801c03ea541ac065"));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body)["articles"];

      mainText = "";
      for (int i = 0; i < 5; i++) {
        mainText += News.fromJson(json[i]).toString();
      }
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "NewsPP",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      searchText = value;
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: FloatingActionButton.extended(
                    onPressed: _search,
                    label: const Text(
                        "Search",
                        style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        )
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              mainText,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            Container(

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _search,
        tooltip: 'Increment',
      ), // This trailing comma makes auto-formatting nicer for build methods.
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