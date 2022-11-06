import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required this.movieData,
  }) : super(key: key);

  final MovieResult movieData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      // color: Colors.green,
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movieData.backdropPath}'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 130,
              width: 180,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ModifiedText(
                    size: 14,
                    maxLines: 1,
                    text: movieData.title ?? 'Loading',
                  ),
                  ModifiedText(
                    size: 12,
                    color: Colors.grey,
                    text: movieData.releaseDate ?? 'Loading',
                  ),
                  Chip(
                    label: Text(movieData.voteCount.toString()),
                    avatar: const Icon(
                      Icons.remove_red_eye,
                      size: 20,
                    ),
                    labelStyle: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.adaptive.more)),
        ],
      ),
    );
  }
}
