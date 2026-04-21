import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie_model.dart';
import 'detail_screen.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  final ApiService api = ApiService();
  List<Movie> tvShows = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTV();
  }

  void loadTV() async {
    final data = await api.fetchMovies("trending/tv/week");
    setState(() {
      tvShows = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("TV Shows"),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: tvShows.length,
        itemBuilder: (context, index) {
          final show = tvShows[index];

          return ListTile(
            leading: Image.network(
              "https://image.tmdb.org/t/p/w200${show.posterPath}",
            ),
            title: Text(show.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(movie: show),
                ),
              );
            },
          );
        },
      ),
    );
  }
}