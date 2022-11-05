import 'package:flutter/material.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({Key? key, required this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifiedText(
            text: 'Top Rated Movies',
            size: 26,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: toprated.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 140,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500' +
                                  toprated[index]['poster_path'],
                            ),
                          ),
                        ),
                        height: 200,
                      ),
                      const SizedBox(height: 5),
                      ModifiedText(
                          size: 15, text: toprated[index]['title'] ?? 'Loading')
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
