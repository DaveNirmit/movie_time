import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class ApiService {
  static const String apiKey = "62f1edd4f680e342de7457a4bf17bea9"; // 🔑 paste here
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageBase = "https://image.tmdb.org/t/p/w500";

  Future<List<Movie>> fetchMovies(String endpoint) async {
    final url = Uri.parse(
        "https://api.codetabs.com/v1/proxy?quest=$baseUrl/$endpoint?api_key=$apiKey"
    );

    final response = await http.get(url);

    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  Future<List<Movie>> getTrending() => fetchMovies("trending/movie/week");
  Future<List<Movie>> getPopular() => fetchMovies("movie/popular");
  Future<List<Movie>> getUpcoming() => fetchMovies("movie/upcoming");

  Future<List<Movie>> searchMovies(String query) {
    return fetchMovies("search/movie?query=$query");
  }
}