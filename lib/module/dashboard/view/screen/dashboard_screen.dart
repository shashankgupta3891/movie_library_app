import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/module/dashboard/view/components/drawer.dart';
import 'package:movie_playlist/module/dashboard/view/components/public_playlist_watcher.dart';
import 'package:movie_playlist/module/dashboard/view/components/top_rated_movies.dart';
import 'package:movie_playlist/module/dashboard/view/components/trending_movies.dart';
import 'package:movie_playlist/module/dashboard/view/components/tv.dart';
import 'package:movie_playlist/route/route_manager.dart';

import '../../controller/dashboard_viewmodel.dart';

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
      context.read<DashboardViewModel>().onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DashboardViewModel>();

    final isLoading =
        context.select<DashboardViewModel, bool>((value) => value.isLoading);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.pushNamed(context, RouteManager.searchScreen);
            }),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteManager.profileScreen);
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: const [
                  TV(),
                  PublicPlayListWatcher(),
                  TrendingMovies(),
                  TopRatedMovies(),
                ],
              ),
            ),
    );
  }
}
