import 'package:flutter/material.dart';
import 'package:movie_playlist/core/constants.dart';
import 'package:movie_playlist/module/common/components/text_components.dart';

class Description extends StatelessWidget {
  final String? name, description, vote, launchOn;
  final String bannerUrl, posterUrl;

  const Description({
    Key? key,
    this.name,
    this.description,
    required this.bannerUrl,
    required this.posterUrl,
    this.vote,
    this.launchOn,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: ModifiedText(text: '⭐ Average Rating - $vote'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(10),
            child: ModifiedText(text: name ?? 'Not Loaded', size: 24),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: ModifiedText(
              text: 'Releasing On - ${launchOn ?? Constants.emptyDash}',
              size: 14,
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: 200,
                width: 100,
                child: Image.network(posterUrl),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ModifiedText(
                    text: description ?? Constants.emptyDash,
                    size: 18,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
