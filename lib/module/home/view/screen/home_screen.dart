import 'package:flutter/material.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/home/view/components/top_rated_movies.dart';
import 'package:movie_playlist/module/home/view/components/trending_movies.dart';
import 'package:movie_playlist/module/home/view/components/tv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ModifiedText(text: 'Flutter Movie App ❤️'),
      ),
      body: ListView(
        children: [
          TV(tv: tv),
          TrendingMovies(
            trending: trendingmovies,
          ),
          TopRatedMovies(
            toprated: topratedmovies,
          ),
        ],
      ),
    );
  }
}
