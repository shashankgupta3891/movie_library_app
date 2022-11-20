import 'package:movie_playlist/model/movie_result.dart';

class FirestoreUserModel {
  static const playListKey = 'playlist';

  String? email;
  String? name;
  List<MovieResult>? privateMovieList;
  List<MovieResult>? publicMovieList;
  List<String>? playlist;

  FirestoreUserModel({
    this.email,
    this.name,
    this.privateMovieList,
    this.publicMovieList,
    this.playlist,
  });

  FirestoreUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    if (json['private_movie_list'] != null) {
      privateMovieList = <MovieResult>[];
      json['private_movie_list'].forEach((v) {
        privateMovieList?.add(MovieResult.fromJson(v));
      });
    }
    if (json['public_movie_list'] != null) {
      publicMovieList = <MovieResult>[];
      json['public_movie_list'].forEach((v) {
        publicMovieList?.add(MovieResult.fromJson(v));
      });
    }

    if (json[playListKey] != null) {
      playlist = <String>[];
      json[playListKey].forEach((v) {
        playlist?.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;

    if (privateMovieList != null) {
      data['private_movie_list'] =
          privateMovieList?.map((v) => v.toJson()).toList();
    }

    if (publicMovieList != null) {
      data['public_movie_list'] =
          publicMovieList?.map((v) => v.toJson()).toList();
    }

    if (playlist != null) {
      data[playListKey] = playlist?.toList() ?? [];
    }
    return data;
  }
}
