import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/home/controller/home_viewmodel.dart';
import 'package:movie_playlist/module/home/view/components/movie_list.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final movieData = context.select<HomeViewModel, List<MovieResult>>(
        (value) => value.trendingmovies);

    return MovieList(movieResultList: movieData);
  }
}
