// ignore_for_file: non_constant_identifier_names, empty_constructor_bodies

import 'package:blog/features/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.image_url,
    required super.topics,
    required super.updated_at,
    required super.poster_id,
    super.poster_name,
  });

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        image_url: map['image_url'],
        topics: List<String>.from(map['topics']),
        updated_at: map['updated_at'] == null
            ? DateTime.now()
            : DateTime.parse(map['updated_at']),
        poster_id: map['poster_id']);
  }

  Map toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image_url': image_url,
      'topics': topics,
      'updated_at': updated_at.toIso8601String(),
      'poster_id': poster_id
    };
  }

  BlogModel copyWith(
      {String? id,
      String? posterid,
      String? title,
      String? content,
      String? imageUrl,
      List<String>? topics,
      DateTime? updatedat,
      String? posterName}) {
    return BlogModel(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        image_url: imageUrl ?? image_url,
        topics: topics ?? this.topics,
        updated_at: updated_at,
        poster_id: poster_id,
        poster_name: posterName);
  }
}
