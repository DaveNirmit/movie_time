import 'dart:async';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie_model.dart';
import 'movies_screen.dart';
import 'tv_screen.dart';
import 'search_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();

  List<Movie> trending = [];
  List<Movie> popular = [];
  List<Movie> upcoming = [];

  bool isLoading = true;

  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    loadData();
    startAutoScroll();
  }

  void startAutoScroll() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && trending.isNotEmpty) {
        currentPage++;
        if (currentPage >= trending.length.clamp(0, 5)) {
          currentPage = 0;
        }

        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void loadData() async {
    try {
      final t = await api.getTrending();
      final p = await api.getPopular();
      final u = await api.getUpcoming();

      setState(() {
        trending = t;
        popular = p;
        upcoming = u;
        isLoading = false;
      });
    } catch (e) {
      print("ERROR: $e");
      setState(() => isLoading = false);
    }
  }

  // 🔹 Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 🎬 Movie List
  Widget movieList(List<Movie> movies) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (movies.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text("No data found"),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(movie: movie),
                ),
              );
            },
            child: Container(
              width: 130,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 🎬 Hero Carousel
  Widget heroSection() {
    if (isLoading || trending.isEmpty) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final items = trending.take(5).toList();

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            itemBuilder: (context, index) {
              final movie = items[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(movie: movie),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/w780${movie.backdropPath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      right: 30,
                      bottom: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.overview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(items.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 10 : 6,
              height: currentPage == index ? 10 : 6,
              decoration: BoxDecoration(
                color: currentPage == index ? Colors.orange : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }

  // 🔻 Footer
  Widget footerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(color: Colors.black),
      child: const Column(
        children: [
          Text("Movie Time",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange)),
          SizedBox(height: 10),
          Text("Name: Dave Nirmit"),
          Text("Enroll: 20230905090028"),
          Text("Gyanmanjari Innovative University"),
          Text("Android Development Framework"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Movie Time",
          style: TextStyle(
            fontFamily: "Bazooka",
            fontSize: 24,
            color: Colors.orange,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text("Home", style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MoviesScreen()));
              },
              child:
              const Text("Movies", style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TvScreen()));
              },
              child: const Text("TV", style: TextStyle(color: Colors.white))),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            heroSection(),

            sectionTitle("Trending"),
            movieList(trending),

            sectionTitle("Latest Movies"),
            movieList(popular),

            sectionTitle("Upcoming"),
            movieList(upcoming),

            const SizedBox(height: 30),
            footerSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}