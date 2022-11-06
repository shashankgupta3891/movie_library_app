import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/dashboard/controller/dashboard_viewmodel.dart';
import 'package:movie_playlist/module/dashboard/view/components/movie_list.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DashboardViewModel>().onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DashboardViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const ModifiedText(text: "Library"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<FirestoreUserModel>(
        stream: viewModel.getUserDataSnapshot(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView(
              children: [
                MovieList(
                  title: "Public Movie List",
                  movieResultList: snapshot.data?.publicMovieList ?? [],
                  isLibrary: true,
                ),
                MovieList(
                  title: "Private Movie List",
                  movieResultList: snapshot.data?.privateMovieList ?? [],
                  isLibrary: true,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
