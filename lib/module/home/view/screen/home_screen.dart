import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/home/view/components/top_rated_movies.dart';
import 'package:movie_playlist/module/home/view/components/trending_movies.dart';
import 'package:movie_playlist/module/home/view/components/tv.dart';

import '../../controller/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeViewModel>().onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();

    final isLoading =
        context.select<HomeViewModel, bool>((value) => value.isLoading);
    return Scaffold(
      appBar: AppBar(
        title: const ModifiedText(text: 'Flutter Movie App ❤️'),
      ),
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: const [
                TV(),
                TrendingMovies(),
                TopRatedMovies(),
              ],
            ),
    );
  }
}
