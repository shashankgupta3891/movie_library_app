import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:uuid/uuid.dart';

class PlayListModel {
  String? id;
  String name;
  bool isPrivate = false;
  String description;
  String url;
  List<MovieResult> movies = [];
  PlayListModel({
    this.id,
    required this.name,
    required this.isPrivate,
    required this.description,
    required this.url,
    required this.movies,
  }) {
    id = id ?? const Uuid().v4();
  }

  PlayListModel copyWith({
    String? id,
    String? name,
    bool? isPrivate,
    String? description,
    String? url,
    List<MovieResult>? movies,
  }) {
    return PlayListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isPrivate: isPrivate ?? this.isPrivate,
      description: description ?? this.description,
      url: url ?? this.url,
      movies: movies ?? this.movies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isPrivate': isPrivate,
      'description': description,
      'url': url,
      'movies': movies.map((x) => x.toJson()).toList(),
    };
  }

  factory PlayListModel.fromMap(Map<String, dynamic> map) {
    return PlayListModel(
      id: map['id'],
      name: map['name'] ?? '',
      isPrivate: map['isPrivate'] ?? false,
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      movies: List<MovieResult>.from(
          map['movies']?.map((x) => MovieResult.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayListModel.fromJson(String source) =>
      PlayListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlayListModel(id: $id, name: $name, isPrivate: $isPrivate, description: $description, url: $url, movies: $movies)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlayListModel &&
        other.id == id &&
        other.name == name &&
        other.isPrivate == isPrivate &&
        other.description == description &&
        other.url == url &&
        listEquals(other.movies, movies);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isPrivate.hashCode ^
        description.hashCode ^
        url.hashCode ^
        movies.hashCode;
  }
}
