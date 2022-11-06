import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/search/controller/search_viewmodel.dart';
import 'package:movie_playlist/module/search/view/components/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SearchViewModel>();
    final movieData = context.select<SearchViewModel, List<MovieResult>>(
        (value) => value.searchMovieList);
    final isLoading =
        context.select<SearchViewModel, bool>((value) => value.isLoading);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: viewModel.query,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.grey.shade50.withOpacity(0.1),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'Search',
                ),
                onChanged: (value) {
                  viewModel.setSearchQuery(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ModifiedText(
                text: movieData.isEmpty
                    ? "No Result Available"
                    : 'Searched Movies',
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: (isLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: movieData.length,
                      itemBuilder: (context, index) {
                        final movie = movieData[index];

                        return SearchCard(movieData: movie);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
