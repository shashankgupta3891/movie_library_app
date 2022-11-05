import 'package:flutter/material.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({Key? key, required this.tv}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifiedText(
            text: 'Popular TV Shows',
            size: 26,
          ),
          const SizedBox(height: 10),
          SizedBox(
            // color: Colors.red,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tv.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  // color: Colors.green,
                  width: 250,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500' +
                                      tv[index]['backdrop_path']),
                              fit: BoxFit.cover),
                        ),
                        height: 140,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        child: ModifiedText(
                            size: 15,
                            text: tv[index]['original_name'] ?? 'Loading'),
                      )
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
