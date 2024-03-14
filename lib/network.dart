import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class BrowserView /*extends StatefulWidget*/ {
  final String url;

  const BrowserView({/*super.key,*/ required this.url});

/*  @override
  State<BrowserView> createState() {
    return _BrowserViewState();
  }*/

  Future<void> launch() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception("Could not launch $url");
    }
  }
}

/*
class _BrowserViewState extends State<BrowserView> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}*/
