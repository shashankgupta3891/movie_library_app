import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'decorations.dart';
import 'firebase_options.dart';

final actionCodeSettings = ActionCodeSettings(
  url: 'https://flutterfire-e2e-tests.firebaseapp.com',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);
// final emailLinkProviderConfig = EmailLinkAuthProvider(
//   actionCodeSettings: actionCodeSettings,
// );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // emailLinkProviderConfig,
    // PhoneAuthProvider(),
    // GoogleProvider(clientId: GOOGLE_CLIENT_ID),
    // AppleProvider(),
    // FacebookProvider(clientId: FACEBOOK_CLIENT_ID),
    // TwitterProvider(
    //   apiKey: TWITTER_API_KEY,
    //   apiSecretKey: TWITTER_API_SECRET_KEY,
    //   redirectUri: TWITTER_REDIRECT_URI,
    // ),
  ]);

  runApp(const FirebaseAuthUIExample());
}

// Overrides a label for en locale
// To add localization for a custom language follow the guide here:
// https://flutter.dev/docs/development/accessibility-and-localization/internationalization#an-alternative-class-for-the-apps-localized-resources
class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
}

class FirebaseAuthUIExample extends StatelessWidget {
  const FirebaseAuthUIExample({Key? key}) : super(key: key);

  String get initialRoute {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      return '/sign-in';
    }

    if (!auth.currentUser!.emailVerified && auth.currentUser!.email != null) {
      return '/';
    }

    return '/profile';
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    final mfaAction = AuthStateChangeAction<MFARequired>(
      (context, state) async {
        final nav = Navigator.of(context);

        await startMFAVerification(
          resolver: state.resolver,
          context: context,
        );

        nav.pushReplacementNamed('/profile');
      },
    );

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
      initialRoute: initialRoute,
      routes: {
        '/sign-in': (context) {
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
                  Navigator.pushNamed(context, '/');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
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
            headerBuilder: headerImage('assets/images/flutterfire_logo.png'),
            sideBuilder: sideImage('assets/images/flutterfire_logo.png'),
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome to Firebase UI! Please sign in to continue.'
                      : 'Welcome to Firebase UI! Please create an account to continue',
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
        },
        // '/verify-email': (context) {
        //   return EmailVerificationScreen(
        //     headerBuilder: headerIcon(Icons.verified),
        //     sideBuilder: sideIcon(Icons.verified),
        //     // actionCodeSettings: actionCodeSettings,
        //     actions: [
        //       EmailVerifiedAction(() {
        //         Navigator.pushReplacementNamed(context, '/profile');
        //       }),
        //       AuthCancelledAction((context) {
        //         FirebaseUIAuth.signOut(context: context);
        //         Navigator.pushReplacementNamed(context, '/');
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
        //         Navigator.of(context).pushReplacementNamed('/profile');
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

        '/': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return const HomeScreen();
        },
        // '/email-link-sign-in': (context) {
        //   return EmailLinkSignInScreen(
        //     actions: [
        //       AuthStateChangeAction<SignedIn>((context, state) {
        //         Navigator.pushReplacementNamed(context, '/');
        //       }),
        //     ],
        //     provider: emailLinkProviderConfig,
        //     headerMaxExtent: 200,
        //     headerBuilder: headerIcon(Icons.link),
        //     sideBuilder: sideIcon(Icons.link),
        //   );
        // },
        '/profile': (context) {
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
        },
      },
      title: 'Firebase UI demo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Container(),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseUIAuth.signOut(context: context);
              Navigator.pushReplacementNamed(context, '/sign-in');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Text("Body"),
    );
  }
}
