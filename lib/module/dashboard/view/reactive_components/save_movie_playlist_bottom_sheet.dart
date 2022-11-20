import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/bottom_sheet_action_button.dart';
import 'package:movie_playlist/module/dashboard/view/reactive_components/create_playlist_bottom_sheet.dart';

import '../../../../common_import/ui_common_import.dart';
import '../../controller/save_movie_to_playlist_viewmodel.dart';

void showSaveMovieToPlayListBottomSheet(
    BuildContext context, MovieResult movieResult) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return ChangeNotifierProvider<SaveMovieToPlaylistViewModel>(
        create: (_) => SaveMovieToPlaylistViewModel(movieResult),
        child: const SaveMovieToPlayListBottomSheet(),
      );
    },
  );
}

class SaveMovieToPlayListBottomSheet extends StatelessWidget {
  const SaveMovieToPlayListBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SaveMovieToPlaylistViewModel>();
    final isLoading = context.select<SaveMovieToPlaylistViewModel, bool>(
        ((value) => value.isLoading));

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                ListTile(
                  title: const Text('Add to Playlist'),
                  trailing: IconButton(
                    onPressed: () {
                      showCreatePlaylistBottomSheet(context);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: StreamBuilder<FirestoreUserModel>(
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
                        List<String> playListIdList =
                            snapshot.data?.playlist ?? [];
                        return Scrollbar(
                          child: ListView.builder(
                            itemCount: playListIdList.length,
                            itemBuilder: (context, index) {
                              return PlayListListTile(
                                playListId: playListIdList[index],
                              );
                            },
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                ),
                const Divider(),
                BottomSheetActionButton(
                  onPressed: () => {
                    viewModel.onSubmit().then((value) {
                      if (value) {
                        Navigator.pop(context);
                      }
                    }),
                  },
                  buttonText: "Add To Playlist",
                ),
              ],
            ),
    );
  }
}

class PlayListListTile extends StatelessWidget {
  final String playListId;
  const PlayListListTile({super.key, required this.playListId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SaveMovieToPlaylistViewModel>();
    return StreamBuilder(
      stream: viewModel.getPlaylist(playListId),
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
          final status = context.select<SaveMovieToPlaylistViewModel, bool>(
              (value) => value.getSelectStatus(playListId));
          final data = snapshot.data;
          return CheckboxListTile(
            title: Text(data?.name ?? 'Playlist Name'),
            onChanged: (bool? value) {
              if (value != null) viewModel.setSelectStatus(playListId, value);
            },
            value: status,
            selected: false,
            controlAffinity: ListTileControlAffinity.leading,
            secondary:
                (data?.isPrivate ?? false) ? const Icon(Icons.lock) : null,
          );
        }
        return const SizedBox();
      },
    );
  }
}
