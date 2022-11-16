import 'package:movie_playlist/module/common/components/bottom_sheet_action_button.dart';

import '../../../../common_import/ui_common_import.dart';

void showSaveMovieToPlayListBottomSheet(BuildContext context) {
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
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        children: [
          ListTile(
            title: const Text('Add to Playlist'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 11,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: const Text('Playlist Name'),
                  onChanged: (bool? value) {},
                  value: true,
                  selected: false,
                );
              },
            ),
          ),
          const Divider(),
          BottomSheetActionButton(
            onPressed: () {},
            buttonText: "Add To Playlist",
          ),
        ],
      ),
    );
  }
}
