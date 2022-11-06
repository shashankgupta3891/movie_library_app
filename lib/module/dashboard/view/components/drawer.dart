import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/provider/app_provider.dart';
import 'package:movie_playlist/route/route_manager.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user =
        context.select<AppProvider, User?>((value) => value.currentUser);
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            // decoration: BoxDecoration(
            //   color: Colors.blue,
            // ),
            accountEmail: Text(user?.email ?? 'NA'),
            accountName: Text(user?.displayName ?? 'NA'),
            currentAccountPicture: const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pushNamed(context, RouteManager.profileScreen);
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
