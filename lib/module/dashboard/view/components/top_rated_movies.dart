import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';
import 'package:movie_playlist/module/dashboard/view/components/movie_list.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final movieData = context.select<DashboardViewModel, List<MovieResult>>(
        (value) => value.topratedmovies);

    return MovieList(title: "Top Rated Movies", movieResultList: movieData);
  }
}
