import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';

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
          return ListView.builder(
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
                                            child: CircularProgressIndicator(),
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
                                                  clipBehavior: Clip.antiAlias,
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
                                                    text: movieResult?.title ??
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
          );
        }

        return Container();
      },
    );
  }
}
