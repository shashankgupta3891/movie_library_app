import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:fluto/core/plugin_manager.dart';
import 'package:fluto/fluto.dart';
import 'package:fluto/ui/components/screen_wrapper.dart';
import 'package:fluto_alice/fluto_alice.dart';
import 'package:fluto_network_inspector/fluto_network.dart';
import 'package:fluto_network_inspector/fluto_network_inseptor.dart';
import 'package:fluto_shared_preferences_viewer/fluto_shared_preferences_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_playlist/core/localization/label_overrides_localization.dart';
import 'package:movie_playlist/core/service/navigator_service.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/provider/provider_scope.dart';
import 'package:movie_playlist/route/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'firebase_options.dart';

FlutoNetwork flutoNetwork = FlutoNetwork();

FlutoAlice alice = FlutoAlice();

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

  final pref = await SharedPreferences.getInstance();

  pref.setInt('count', 999);
  pref.setString('username', 'John Appleseed');
  pref.setBool('didViewedPolicy', false);
  pref.setDouble('height', 1234.5678);
  pref.setStringList(
    'staredLanguage',
    ['Dart', 'Swift', 'Kotlin', 'Objective-C', 'Java'],
  );

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
    FlutoAlicePlugin(const Uuid().v4(), alice),
    FlutoSharedPreferencesViewerPlugin(const Uuid().v4()),
    FlutoLoggerPlugin(const Uuid().v4(), FlutoLogger()),
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
