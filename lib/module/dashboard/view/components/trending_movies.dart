import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';
import 'package:movie_playlist/module/dashboard/view/components/movie_list.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final movieData = context.select<DashboardViewModel, List<MovieResult>>(
        (value) => value.trendingmovies);

    return MovieList(title: "Trending Movies", movieResultList: movieData);
  }
}
