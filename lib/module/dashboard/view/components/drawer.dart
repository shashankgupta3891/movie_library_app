import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/module/dashboard/view/reactive_components/create_playlist_bottom_sheet.dart';
import 'package:movie_playlist/provider/app_provider.dart';
import 'package:movie_playlist/route/route_manager.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AppProvider>();
    return Drawer(
      child: Column(
        children: [
          StreamBuilder<User?>(
            stream: viewModel.userChanges(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              return UserAccountsDrawerHeader(
                accountEmail: Text(user?.email ?? 'NA'),
                accountName: Text(user?.displayName ?? 'NA'),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pushNamed(context, RouteManager.profileScreen);
            },
          ),
          ListTile(
            title: const Text('Create Playlist'),
            leading: const Icon(Icons.create),
            onTap: () {
              showCreatePlaylistBottomSheet(context);
            },
          ),
          ListTile(
            title: const Text('Playlist'),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.pushNamed(context, RouteManager.libraryScreen);
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.logout),
            onTap: () {
              FirebaseUIAuth.signOut(context: context);
              Navigator.pushReplacementNamed(
                  context, RouteManager.signInScreen);
            },
          ),
        ],
      ),
    );
  }
}
