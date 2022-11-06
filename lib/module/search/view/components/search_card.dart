import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/search/controller/search_viewmodel.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required this.movieData,
  }) : super(key: key);

  final MovieResult movieData;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SearchViewModel>();
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
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 0,
                // row with 2 children
                child: Row(
                  children: const [
                    Icon(Icons.public),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Save to Public List"),
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 1,
                // row with two children
                child: Row(
                  children: const [
                    Icon(Icons.security),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Save to Private List")
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 100),
            color: Colors.grey,
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              if (value == 1) {
                viewModel.saveMovie(movieResult: movieData, isPrivate: false);
              } else {
                viewModel.saveMovie(movieResult: movieData, isPrivate: true);
              }
            },
          ),
        ],
      ),
    );
  }
}
