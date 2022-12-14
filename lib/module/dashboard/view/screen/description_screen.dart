import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/core/constants.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';
import 'package:movie_playlist/module/dashboard/view/reactive_components/save_movie_playlist_bottom_sheet.dart';

class Description extends StatelessWidget {
  final MovieResult movieResult;
  final bool isLibrary;

  String get bannerUrl =>
      'https://image.tmdb.org/t/p/w500${movieResult.backdropPath}';

  String get posterUrl =>
      'https://image.tmdb.org/t/p/w500${movieResult.posterPath}';

  const Description({
    Key? key,
    required this.movieResult,
    this.isLibrary = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DashboardViewModel>();
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: ModifiedText(
                      text: '⭐ Average Rating - ${movieResult.voteAverage}'),
                ),
                if (Navigator.canPop(context))
                  const Positioned(
                    top: 10,
                    child: BackButton(),
                  ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      if (isLibrary) {
                        viewModel.removeMovie(
                            movieResult: movieResult, isPrivate: true);
                      } else {
                        showSaveMovieToPlayListBottomSheet(
                            context, movieResult);
                      }
                    },
                    icon: Icon((isLibrary) ? Icons.delete : Icons.bookmark),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(10),
            child:
                ModifiedText(text: movieResult.title ?? 'Not Loaded', size: 24),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: ModifiedText(
              text:
                  'Releasing On - ${movieResult.releaseDate ?? Constants.emptyDash}',
              size: 14,
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: 200,
                width: 100,
                child: Image.network(posterUrl),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ModifiedText(
                    text: movieResult.overview ?? Constants.emptyDash,
                    size: 18,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
