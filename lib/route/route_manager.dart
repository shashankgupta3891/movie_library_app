import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/module/auth/view/screen/auth_screen.dart';
import 'package:movie_playlist/module/auth/view/screen/profile_screen.dart';
import 'package:movie_playlist/module/dashboard/view/screen/dashboard_screen.dart';
import 'package:movie_playlist/module/dashboard/view/screen/library_screen.dart';
import 'package:movie_playlist/module/search/view/screen/search_screen.dart';

class RouteManager {
  static const homeScreen = '/';
  static const profileScreen = '/profile';

  static const signInScreen = '/sign-in';
  static const searchScreen = '/search';
  static const libraryScreen = '/library';

  static final _mfaAction = AuthStateChangeAction<MFARequired>(
    (context, state) async {
      final nav = Navigator.of(context);

      await startMFAVerification(
        resolver: state.resolver,
        context: context,
      );

      nav.pushReplacementNamed(profileScreen);
    },
  );

  static String get initialRoute {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      return signInScreen;
    }

    if (!auth.currentUser!.emailVerified && auth.currentUser!.email != null) {
      return homeScreen;
    }

    return profileScreen;
  }

  static final routes = {
    signInScreen: (context) {
      return AuthScreen(mfaAction: _mfaAction);
    },
    libraryScreen: (context) {
      return const LibraryScreen();
    },
    // '/verify-email': (context) {
    //   return EmailVerificationScreen(
    //     headerBuilder: headerIcon(Icons.verified),
    //     sideBuilder: sideIcon(Icons.verified),
    //     // actionCodeSettings: actionCodeSettings,
    //     actions: [
    //       EmailVerifiedAction(() {
    //         Navigator.pushReplacementNamed(context, profileScreen);
    //       }),
    //       AuthCancelledAction((context) {
    //         FirebaseUIAuth.signOut(context: context);
    //         Navigator.pushReplacementNamed(context, homeScreen);
    //       }),
    //     ],
    //   );
    // },
    // '/phone': (context) {
    //   return PhoneInputScreen(
    //     actions: [
    //       SMSCodeRequestedAction((context, action, flowKey, phone) {
    //         Navigator.of(context).pushReplacementNamed(
    //           '/sms',
    //           arguments: {
    //             'action': action,
    //             'flowKey': flowKey,
    //             'phone': phone,
    //           },
    //         );
    //       }),
    //     ],
    //     headerBuilder: headerIcon(Icons.phone),
    //     sideBuilder: sideIcon(Icons.phone),
    //   );
    // },
    // '/sms': (context) {
    //   final arguments = ModalRoute.of(context)?.settings.arguments
    //       as Map<String, dynamic>?;

    //   return SMSCodeInputScreen(
    //     actions: [
    //       AuthStateChangeAction<SignedIn>((context, state) {
    //         Navigator.of(context).pushReplacementNamed(profileScreen);
    //       })
    //     ],
    //     flowKey: arguments?['flowKey'],
    //     action: arguments?['action'],
    //     headerBuilder: headerIcon(Icons.sms_outlined),
    //     sideBuilder: sideIcon(Icons.sms_outlined),
    //   );
    // },
    // '/forgot-password': (context) {
    //   final arguments = ModalRoute.of(context)?.settings.arguments
    //       as Map<String, dynamic>?;

    //   return ForgotPasswordScreen(
    //     email: arguments?['email'],
    //     headerMaxExtent: 200,
    //     headerBuilder: headerIcon(Icons.lock),
    //     sideBuilder: sideIcon(Icons.lock),
    //   );
    // },

    homeScreen: (context) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      return const HomeScreen();
    },
    searchScreen: (context) {
      return const SearchScreen();
    },
    // '/email-link-sign-in': (context) {
    //   return EmailLinkSignInScreen(
    //     actions: [
    //       AuthStateChangeAction<SignedIn>((context, state) {
    //         Navigator.pushReplacementNamed(context, homeScreen);
    //       }),
    //     ],
    //     provider: emailLinkProviderConfig,
    //     headerMaxExtent: 200,
    //     headerBuilder: headerIcon(Icons.link),
    //     sideBuilder: sideIcon(Icons.link),
    //   );
    // },
    profileScreen: (context) {
      return CustomProfileScreen(mfaAction: _mfaAction);
    },
  };
}
