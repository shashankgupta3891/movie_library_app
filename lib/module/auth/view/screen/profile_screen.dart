import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';

class CustomProfileScreen extends StatelessWidget {
  const CustomProfileScreen({
    Key? key,
    required this.mfaAction,
  }) : super(key: key);

  final AuthStateChangeAction<MFARequired> mfaAction;

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/sign-in');
        }),
        mfaAction,
      ],
      // actionCodeSettings: actionCodeSettings,
      showMFATile: true,
    );
  }
}
