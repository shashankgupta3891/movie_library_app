import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';
import 'package:movie_playlist/module/home/controller/home_viewmodel.dart';

class TV extends StatelessWidget {
  const TV({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final movieData =
        context.select<HomeViewModel, List<MovieResult>>((value) => value.tv);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ModifiedText(
            text: 'Popular TV Shows',
            size: 26,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: movieData.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                // color: Colors.green,
                width: 250,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movieData[index].backdropPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 140,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      child: ModifiedText(
                        size: 15,
                        text: movieData[index].originalName ?? 'Loading',
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
