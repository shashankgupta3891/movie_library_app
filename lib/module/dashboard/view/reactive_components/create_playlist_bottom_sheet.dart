import 'package:movie_playlist/module/common/components/bottom_sheet_action_button.dart';
import 'package:movie_playlist/module/dashboard/controller/create_playlist_viewmodel.dart';

import '../../../../common_import/ui_common_import.dart';

void showCreatePlaylistBottomSheet(BuildContext context,
    {bool hideToggle = false}) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return ChangeNotifierProvider<CreatePlaylistViewModel>(
        create: (_) => CreatePlaylistViewModel(),
        child: CreatePlayListBottomSheet(hideToggle: hideToggle),
      );
    },
  );
}

class CreatePlayListBottomSheet extends StatelessWidget {
  const CreatePlayListBottomSheet({
    Key? key,
    required this.hideToggle,
  }) : super(key: key);

  final bool hideToggle;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreatePlaylistViewModel>();
    viewModel.handleError((e, s) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return true;
    });

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const ListTile(
                  title: Text('Create New Playlist'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: viewModel.playlistName,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.grey.shade50.withOpacity(0.1),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0.1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      labelText: 'PlayList Name',
                    ),
                    onChanged: viewModel.setPlaylistName,
                  ),
                ),
                if (!hideToggle)
                  SwitchListTile.adaptive(
                    title: const Text("Private"),
                    onChanged: viewModel.setIsPrivate,
                    value: viewModel.isPrivate,
                  ),
                const Spacer(),
                const Divider(),
                ActionButton(
                  onPressed: (viewModel.playlistName.isNotEmpty)
                      ? () {
                          viewModel
                              .onSubmit()
                              .then((value) => Navigator.pop(context));
                        }
                      : null,
                  buttonText: "Create Playlist",
                ),
              ],
            ),
    );
  }
}
