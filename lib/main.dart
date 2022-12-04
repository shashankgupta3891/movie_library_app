import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_playlist/core/localization/label_overrides_localization.dart';
import 'package:movie_playlist/core/service/navigator_service.dart';
import 'package:movie_playlist/fluto_project/components/screen_wrapper.dart';
import 'package:movie_playlist/fluto_project/core/plugin_manager.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/fluto_network.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/fluto_network_inseptor.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/provider/provider_scope.dart';
import 'package:movie_playlist/route/route_manager.dart';
import 'package:uuid/uuid.dart';

import 'firebase_options.dart';
import 'fluto_project/fluto.dart';

FlutoNetwork flutoNetwork = FlutoNetwork();

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

  setupDependencies();

  PlutoPluginManager.registerAllPlugins([
    FlutoNetworkInspenctor(const Uuid().v4(), flutoNetwork),
  ]);

  runApp(
    Fluto(
      navigatorKey: locator<NavigationService>().navigatorKey,
      child: const ProviderScope(child: MovieLibraryApp()),
    ),
  );
}

class MovieLibraryApp extends StatelessWidget {
  const MovieLibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      builder: (context, child) => FlutoScreenWrapper(child: child!),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
      initialRoute: RouteManager.initialRoute,
      routes: RouteManager.routes,
      title: 'Movie Watcher',
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
