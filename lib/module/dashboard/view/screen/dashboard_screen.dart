import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/dashboard/view/components/drawer.dart';
import 'package:movie_playlist/module/dashboard/view/components/top_rated_movies.dart';
import 'package:movie_playlist/module/dashboard/view/components/trending_movies.dart';
import 'package:movie_playlist/module/dashboard/view/components/tv.dart';
import 'package:movie_playlist/route/route_manager.dart';

import '../../../../model/firebase_user_model.dart';
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
        // title: const ModifiedText(text: 'Flutter Movie App ❤️'),
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
          : ListView(
              children: const [
                TV(),
                PublicPlayListWatcher(),
                TrendingMovies(),
                TopRatedMovies(),
              ],
            ),
    );
  }
}

class PublicPlayListWatcher extends StatelessWidget {
  const PublicPlayListWatcher({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DashboardViewModel>();
    return StreamBuilder<FirestoreUserModel>(
      stream: viewModel.getUserDataSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.hasData) {
          List<String> playListIdList = snapshot.data?.playlist ?? [];
          return Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: playListIdList.length,
              itemBuilder: (context, index) {
                return StreamBuilder<PlayListModel>(
                  stream: viewModel.getPlaylist(playListIdList[index]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data?.isPrivate ?? false) {
                        return Container();
                      }
                      final playlist = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ModifiedText(
                              text: playlist?.name ?? '',
                              size: 26,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 270,
                            child: playlist?.movies.isEmpty ?? true
                                ? const Center(child: Text("No Data Available"))
                                : ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: playlist?.movies.length,
                                    itemBuilder: (context, index) {
                                      final movieId =
                                          playlist?.movies[index] ?? "";

                                      return FutureBuilder<MovieResult>(
                                        future: viewModel.getMovie(movieId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  "${snapshot.error.toString()} $movieId"),
                                            );
                                          }

                                          if (snapshot.hasData) {
                                            final movieResult = snapshot.data;
                                            return SizedBox(
                                              width: 140,
                                              child: Column(
                                                children: [
                                                  Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            'https://image.tmdb.org/t/p/w500${movieResult?.posterPath}',
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
                                                      text:
                                                          movieResult?.title ??
                                                              'Loading',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      );

                                      // return InkWell(
                                      //   onTap: () {
                                      //     // Navigator.push(
                                      //     //   context,
                                      //     //   MaterialPageRoute(
                                      //     //     builder: (context) => Description(
                                      //     //       movieResult:
                                      //     //           playlist?.movies?[index],
                                      //     //       isLibrary: false,
                                      //     //     ),
                                      //     //   ),
                                      //     // );
                                      //   },
                                      //   child: SizedBox(
                                      //     width: 140,
                                      //     child: Column(
                                      //       children: [
                                      //         Card(
                                      //           clipBehavior: Clip.antiAlias,
                                      //           child: Container(
                                      //             decoration: BoxDecoration(
                                      //               image: DecorationImage(
                                      //                 fit: BoxFit.fill,
                                      //                 image: NetworkImage(
                                      //                   'https://image.tmdb.org/t/p/w500${movieResultList[index].posterPath}',
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //             height: 200,
                                      //           ),
                                      //         ),
                                      //         const SizedBox(height: 5),
                                      //         Flexible(
                                      //           child: ModifiedText(
                                      //             size: 15,
                                      //             text: movieResultList[index]
                                      //                     .title ??
                                      //                 'Loading',
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                  ),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
