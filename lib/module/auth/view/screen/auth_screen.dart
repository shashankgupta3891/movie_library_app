import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/module/common/components/image_components.dart';
import 'package:movie_playlist/provider/app_provider.dart';
import 'package:movie_playlist/route/route_manager.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    Key? key,
    required this.mfaAction,
  }) : super(key: key);

  final AuthStateChangeAction<MFARequired> mfaAction;

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        // ForgotPasswordAction((context, email) {
        //   Navigator.pushNamed(
        //     context,
        //     '/forgot-password',
        //     arguments: {'email': email},
        //   );
        // }),
        // VerifyPhoneAction((context, _) {
        //   Navigator.pushNamed(context, '/phone');
        // }),
        AuthStateChangeAction<SignedIn>((context, state) {
          if (!state.user!.emailVerified) {
            Navigator.pushNamed(context, RouteManager.homeScreen);
          } else {
            Navigator.pushReplacementNamed(context, RouteManager.profileScreen);
          }
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          final user = state.credential.user;
          if (user != null) {
            context.read<AppProvider>().saveUserIntoDB(user: user);
          }

          if (!state.credential.user!.emailVerified) {
            Navigator.pushNamed(context, '/');
          } else {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        }),
        mfaAction,
        // EmailLinkSignInAction((context) {
        //   Navigator.pushReplacementNamed(context, '/email-link-sign-in');
        // }),
      ],
      styles: const {
        EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
      },
      headerBuilder: headerImage('assets/images/app-logo.png'),
      sideBuilder: sideImage('assets/images/app-logo.png'),
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            action == AuthAction.signIn
                ? 'Welcome to Movie Watcher! Please sign in to continue.'
                : 'Welcome to Movie Watcher! Please create an account to continue',
          ),
        );
      },
      footerBuilder: (context, action) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              action == AuthAction.signIn
                  ? 'By signing in, you agree to our terms and conditions.'
                  : 'By registering, you agree to our terms and conditions.',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
