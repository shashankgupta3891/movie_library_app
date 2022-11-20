import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: const ModifiedText(text: "Library"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<FirestoreUserModel>(
        stream: viewModel.getUserDataSnapshot(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return const PlayListWatcher();
            // return ListView(
            //   children: const [
            //     PlayListWatcher(),
            //     // MovieList(
            //     //   title: "Public Movie List",
            //     //   movieResultList: snapshot.data?.publicMovieList ?? [],
            //     //   isLibrary: true,
            //     // ),
            //     // MovieList(
            //     //   title: "Private Movie List",
            //     //   movieResultList: snapshot.data?.privateMovieList ?? [],
            //     //   isLibrary: true,
            //     // ),
            //   ],
            // );
          }
          return Container();
        },
      ),
    );
  }
}

class PlayListWatcher extends StatelessWidget {
  const PlayListWatcher({super.key});

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
                      final playlist = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                ModifiedText(
                                  text: playlist?.name ?? '',
                                  size: 26,
                                ),
                                if (playlist?.isPrivate ?? false)
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(Icons.lock),
                                  )
                              ],
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
