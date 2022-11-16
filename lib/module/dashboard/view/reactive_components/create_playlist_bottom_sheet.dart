import 'package:movie_playlist/module/common/components/bottom_sheet_action_button.dart';

import '../../../../common_import/ui_common_import.dart';

void showCreatePlaylistBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return const SaveMovieToPlayListBottomSheet();
    },
  );
}

class SaveMovieToPlayListBottomSheet extends StatelessWidget {
  const SaveMovieToPlayListBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text('Create New Playlist'),
            onTap: () {
              Navigator.pop(context);
              showCreatePlaylistBottomSheet(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: "",
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
              onChanged: (value) {
                // viewModel.setSearchQuery(value);
              },
            ),
          ),
          SwitchListTile.adaptive(
            title: const Text("Private"),
            onChanged: (bool value) {},
            value: true,
          ),
          const Spacer(),
          const Divider(),
          BottomSheetActionButton(
            onPressed: () {},
            buttonText: "Create Playlist",
          ),
        ],
      ),
    );
  }
}
