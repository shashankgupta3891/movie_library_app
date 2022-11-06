import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';
import 'package:movie_playlist/module/search/controller/search_viewmodel.dart';
import 'package:movie_playlist/provider/app_provider.dart';
import 'package:provider/provider.dart';

class ProviderScope extends StatelessWidget {
  const ProviderScope({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => DashboardViewModel()),
        ChangeNotifierProvider(create: (context) => SearchViewModel()),
      ],
      child: child,
    );
  }
}
