import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/home/view/screen/description.dart';

class MovieList extends StatelessWidget {
  final List<MovieResult> movieResultList;
  const MovieList({super.key, required this.movieResultList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ModifiedText(
            text: 'Trending Movies',
            size: 26,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 270,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: movieResultList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Description(
                        name: movieResultList[index].title,
                        bannerUrl:
                            'https://image.tmdb.org/t/p/w500${movieResultList[index].backdropPath}',
                        posterUrl:
                            'https://image.tmdb.org/t/p/w500${movieResultList[index].posterPath}',
                        description: movieResultList[index].overview,
                        vote: movieResultList[index].voteAverage.toString(),
                        launchOn: movieResultList[index].releaseDate,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 140,
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movieResultList[index].posterPath}',
                              ),
                            ),
                          ),
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Flexible(
                        child: ModifiedText(
                          size: 15,
                          text: movieResultList[index].title ?? 'Loading',
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
