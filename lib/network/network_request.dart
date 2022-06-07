
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:themovieapp/module/detail_person_module.dart';
import '../components/textStyle.dart';
import '../module/detail_movie_module.dart';
import '../module/grid_list_module.dart';
import '../module/now_playing_module.dart';

class NetworkRequest {
  static const String apiKey = '?api_key=d79d9f8467a0e6d7b24624c522cb2ab3&append_to_response=credits';
  static const String apiKeyDetailPerson = '?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';
  static const String apiKeyMvCredit = '/movie_credits?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';
  static const String urlImg = 'https://image.tmdb.org/t/p/original/';
  static const String urlImgPerson = 'https://image.tmdb.org/t/p/w300';
  static const String urlLogo1 = 'https://image.tmdb.org/t/p/w45/';
  static const String urlLogo = 'https://image.tmdb.org/t/p/w92/';
  static const String urlMovies ='https://api.themoviedb.org/3/movie/';
  static const String urlPerson = 'https://api.themoviedb.org/3/person/';
  
  static const String urlNowPlaying = 'https://api.themoviedb.org/3/movie/now_playing?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';
  static const String urlUpcoming =   'https://api.themoviedb.org/3/movie/upcoming?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';
  // static const String urlMovie = 'https://api.themoviedb.org/3/movie/${movie_id}?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';
  // static const String urlPerson = 'https://api.themoviedb.org/3/person/${person_id}?api_key=d79d9f8467a0e6d7b24624c522cb2ab3';
}
Future<NowPlaying> fetchDataMovies(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return NowPlaying.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Fail');
  }
}
Future<DetailMovie> fetchDataDetailsMovies(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return DetailMovie.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Fail');
  }
}

Future<DetailPerson> fetchDataDetailsPerson(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return DetailPerson.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Fail');
  }
}

Future<Credit> fetchDataCredits(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Credit.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Fail');
  }
}
Widget gridListMovie(dynamic input) {
  return FutureBuilder<dynamic>(
    future: input,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return gridViewBuilder(snapshot);
      } else if (snapshot.hasError) {
        return  Center(child: Text("Error", style: textStyle(12)));
      }
      return  Center(child: Text("Loading...", style: textStyle(12)));
    },
  );
}

// Widget detailMovie(dynamic input) {
//   return FutureBuilder<dynamic>(
//     future: input,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         return gridViewBuilder(snapshot);
//       } else if (snapshot.hasError) {
//         return const Text("Error");
//       }
//       return const Text("Loading...");
//     },
//   );
// }
