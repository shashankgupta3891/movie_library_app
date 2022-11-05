import 'movie_result.dart';

class TMDBResponseModel {
  int? page;
  List<MovieResult>? results;
  int? totalPages;
  int? totalResults;

  TMDBResponseModel(
      {this.page, this.results, this.totalPages, this.totalResults});

  TMDBResponseModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <MovieResult>[];
      json['results'].forEach((v) {
        results!.add(MovieResult.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
