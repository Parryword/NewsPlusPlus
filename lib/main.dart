import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'error.dart';
import 'news.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchText = "";
  var searchResultsWidget = List<Widget>.empty(growable: true);
  ScrollController? _scrollController;

  Future<void> _search() async {
    if (_searchText.isEmpty) {
      searchResultsWidget.add(const WarningWidget(title: "Invalid search", description: "Please enter the search text.", severity: Severity.mild));
      setState(() {

      });
      return;
    }
    final response = await get(Uri.parse("https://newsapi.org/v2/everything?q=$_searchText&apiKey=1d03b991a18c4c62801c03ea541ac065"));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body)["articles"];
      searchResultsWidget.clear();
      for (int i = 0; i < 1000; i++) {
        News news;
        try {
          news = News.fromJson(json[i]);
        }
        on RangeError catch (e) {
          if (i == 0) {
            searchResultsWidget.add(const WarningWidget(title: "No result", description: "Try searching with another keyword.", severity: Severity.moderate));
          }
          else {
            searchResultsWidget.add(const WarningWidget(title: "End of results", description: "Search something else.", severity: Severity.moderate));
          }
          break;
        }
        on FormatException catch (e) {
          searchResultsWidget.add(const WarningWidget(title: "Unavailable", description: "Failed to load news.", severity: Severity.moderate));
          continue;
        }
        on Exception catch (e) {
          debugPrint(e.toString());
          searchResultsWidget.add(const WarningWidget(title: "Unexpected error", description: "An unexpected error occurred.", severity: Severity.critical));
          continue;
        }
        String title = news.title;
        String description = news.description;
        String url = news.url;
        searchResultsWidget.add(NewsWidget(title: title, description: description, url: url,));
      }
    }
    _scrollController?.jumpTo(0);
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: 196,
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      _searchText = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FloatingActionButton(
                    onPressed: _search,
                    child: const Icon(IconData(0xe567, fontFamily: 'MaterialIcons')),
                ),
              )
            ],
          ),
        )
      ),
      body: ListView.builder(
        itemCount: searchResultsWidget.length,
        itemBuilder: (context, index) => searchResultsWidget[index],
        controller: _scrollController,),
      /*floatingActionButton: FloatingActionButton.extended(
          onPressed: _showMenuPanel,
          label: const Text("Settings"),
          icon: const Icon(IconData(0xe57f, fontFamily: 'MaterialIcons')),
      ),*/
      // Navigator.of(context).
      drawer: Drawer(
        child: ListView(
          children: [
            const ListTile(
                title: Text("View bookmarks"),
            ),
            SwitchListTile(
                title: const Text("Toggle warnings"),
                value: false, onChanged: (bool value) { debugPrint(value as String?); },),
            const ExpansionTile(
                title: Text("Language"),
                children: [
                  ListTile(title: Text("English")),
                  ListTile(title: Text("German")),
                  ListTile(title: Text("Turkish")),
                ]
            ),
            const ListTile(
              title: Text("Export settings"),
            ),
            const ListTile(
              title: Text("Import settings"),
            ),
            const ListTile(
              title: Text("Account settings"),
            ),
          ]
        ),
      ),
    );
  }
}

// TODO: Pubdev url launcher for browser view