import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/dashboard/view/screen/description_screen.dart';

class MovieList extends StatelessWidget {
  final List<MovieResult> movieResultList;
  final bool isLibrary;
  const MovieList({
    super.key,
    required this.movieResultList,
    required this.title,
    this.isLibrary = false,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ModifiedText(
            text: title,
            size: 26,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 270,
          child: movieResultList.isEmpty
              ? const Center(child: Text("No Data Available"))
              : ListView.builder(
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
                              movieResult: movieResultList[index],
                              isLibrary: isLibrary,
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
