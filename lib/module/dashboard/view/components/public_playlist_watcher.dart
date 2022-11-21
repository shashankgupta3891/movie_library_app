import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';
import 'package:movie_playlist/module/common/components/bottom_sheet_action_button.dart';
import 'package:movie_playlist/module/common/components/future_builder_handle.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';
import 'package:movie_playlist/module/dashboard/view/components/movie_list.dart';
import 'package:movie_playlist/module/dashboard/view/reactive_components/create_playlist_bottom_sheet.dart';

class PublicPlayListWatcher extends StatelessWidget {
  const PublicPlayListWatcher({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DashboardViewModel>();
    return StreamBuilderHandle<FirestoreUserModel>(
      stream: viewModel.getUserDataSnapshot(),
      builder: (context, userData) {
        List<String> playListIdList = userData.playlist ?? [];

        if (playListIdList.isEmpty) {
          return ActionButton(
            onPressed: () =>
                showCreatePlaylistBottomSheet(context, hideToggle: true),
            buttonText: "Add Public PlayList",
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: playListIdList.length,
          itemBuilder: (context, index) {
            return StreamBuilderHandle<PlayListModel>(
              stream: viewModel.getPlaylist(playListIdList[index]),
              builder: (context, playlist) {
                if (playlist.isPrivate) {
                  return Container();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ModifiedText(
                        text: playlist.name,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 270,
                      child: playlist.movies.isEmpty
                          ? const Center(child: Text("No Data Available"))
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: playlist.movies.length,
                              itemBuilder: (context, index) {
                                final movieId = playlist.movies[index];

                                return FutureBuilderHandle<MovieResult>(
                                  future: viewModel.getMovie(movieId),
                                  builder: (context, movieResult) {
                                    return MovieCard(movie: movieResult);
                                  },
                                );
                              },
                            ),
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
