import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=a9faefbb24070ab4bf770caee29f1932';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=a9faefbb24070ab4bf770caee29f1932&query=';

  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    final result = await http.get(Uri.parse(upcoming));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) =>
          Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return <Movie>[Movie(1,'title',50,'10/10/10','overview','poster path')];
    }
  }

  Future<List> findMovies(String title) async {
    final String query = urlSearchBase + title ;
    http.Response result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) =>
          Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return <Movie>[Movie(1,'title',50,'10/10/10','overview','poster path')];
    }
  }
}
