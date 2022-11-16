import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';

class FirestoreUserModel {
  String? email;
  String? name;
  List<MovieResult>? privateMovieList;
  List<MovieResult>? publicMovieList;
  List<PlayListModel>? playlist;

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

    if (json['playlist'] != null) {
      playlist = <PlayListModel>[];
      json['playlist'].forEach((v) {
        playlist?.add(PlayListModel.fromJson(v));
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
      data['playlist'] = playlist?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
