import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:se_380/bookmark.dart';
import 'package:se_380/settings.dart';
import 'error.dart';
import 'localization.dart';
import 'news.dart';

Future<void> main() async {
  // Settings load edilmeden çalışmamalı.
  // await f;
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
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
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
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FloatingActionButton(
                      onPressed: _search,
                      child: const Icon(IconData(0xe567, fontFamily: 'MaterialIcons')),
                  ),
                ),
              )
            ],
          ),
        )
      ),
      // Material app
      body: ListView.builder(
        itemCount: searchResultsWidget.length,
        itemBuilder: (context, index) => searchResultsWidget[index],
        controller: _scrollController,),
      // Navigator.of(context).
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
                title: Text(Localization().viewBookmarks),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Bookmark())
                  );
                }
            ),
            SwitchListTile(
                title: Text(Localization().toggleWarnings),
                value: Settings().toggleWarnings, onChanged: (bool value) {
                  setState(() {
                    Settings().toggleWarnings = value;
                  });
                  debugPrint(Settings().toggleWarnings.toString());
            },
            ),
            ExpansionTile(
                title: Text(Localization().language),
                children: [
                  ListTile(title: Text(Localization().english), onTap: () {
                    Settings().chosenLanguage = Language.en;
                    setState(() {

                    });
                  }
                  ),
                  ListTile(title: Text(Localization().german), onTap: () {
                    Settings().chosenLanguage = Language.de;
                    setState(() {

                    });
                  },
                  ),
                  ListTile(title: Text(Localization().turkish), onTap: () {
                    Settings().chosenLanguage = Language.tr;
                    setState(() {

                    });
                  },
                  ),
                ]
            ),
            ListTile(
              title: Text(Localization().exportSettings), onTap: () {
              Settings().save();
              setState(() {

              });

            },
            ),
            ListTile(
              title: Text(Localization().importSettings),
              onTap: () async {
                await Settings.load();
                // Find a better solution
                await Future.delayed(const Duration(milliseconds: 50));
                setState(() {

                });
              },
            ),

            ListTile(
              title: Text(Localization().accountSettings),
            ),
            ListTile(
                title: Text(Localization().clearData), onTap: () {
                  Settings.reset();
                  setState(() {

                  });
            },
            ),
          ]
        ),
      ),
    );
  }

  Future<void> _search() async {
    searchResultsWidget.clear();
    if (_searchText.isEmpty) {
      if (Settings().toggleWarnings) {
        searchResultsWidget.add(const WarningWidget(title: "Invalid search", description: "Please enter the search text.", severity: Severity.mild));
      }
      setState(() {

      });
      return;
    }
    final response = await get(Uri.parse("https://newsapi.org/v2/everything?q=$_searchText&apiKey=1d03b991a18c4c62801c03ea541ac065"));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body)["articles"];
      for (int i = 0; i < 1000; i++) {
        News news;
        try {
          news = News.fromJson(json[i]);
        }
        on RangeError catch (e) {
          if (Settings().toggleWarnings) {
            if (i == 0) {
              searchResultsWidget.add(const WarningWidget(title: "No result", description: "Try searching with another keyword.", severity: Severity.moderate));
            }
            else {
              searchResultsWidget.add(const WarningWidget(title: "End of results", description: "Search something else.", severity: Severity.moderate));
            }
          }
          break;
        }
        on FormatException catch (e) {
          if (Settings().toggleWarnings) {
            searchResultsWidget.add(const WarningWidget(title: "Unavailable", description: "Failed to load news.", severity: Severity.moderate));
          }
          continue;
        }
        on Exception catch (e) {
          if (Settings().toggleWarnings) {
            searchResultsWidget.add(const WarningWidget(title: "Unexpected error", description: "An unexpected error occurred.", severity: Severity.critical));
          }
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
}
