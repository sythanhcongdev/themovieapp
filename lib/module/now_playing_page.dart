import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'now_playing_module.dart';

const url =
    "https://api.themoviedb.org/3/movie/?api_key=d79d9f8467a0e6d7b24624c522cb2ab3&append_to_response=videos";

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  int count = 0;
  bool   isLoading = false;
  String? movieName;
  String? movieBackground;

  @override
  void initState() {
    super.initState();
    _getMovieData();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Container();
    if (isLoading) {
      body = Center(
        child: Text("Loading..."),
      );
    } else {
      body = SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(movieName ?? "Không có dữ liệu"),
            Image.network(
                "https://image.tmdb.org/t/p/w300/${movieBackground}"),
          ],
        ),
      );
    }
    return Scaffold(
      body: body,
    );
  }

  void _getMovieData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body) as Map<String, dynamic>?;
    if (data == null) {
      return;
    }
    final movieName = NowPlaying.fromJson(data);
    final movieBackground = NowPlaying.fromJson(data);
    setState(() {
      isLoading = false;
      
    });
  }
}
