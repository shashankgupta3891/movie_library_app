import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/home/controller/home_viewmodel.dart';
import 'package:movie_playlist/module/home/view/components/movie_list.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final movieData = context.select<HomeViewModel, List<MovieResult>>(
        (value) => value.topratedmovies);

    return MovieList(movieResultList: movieData);
  }
}
