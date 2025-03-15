import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entity/blog.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class Uploadblog implements Usecase<Blog, UploadblogParms> {
  final BlogRepository blogRepository;

  Uploadblog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(Parms) async {
    return await blogRepository.uploadBlog(
        Parms.image, Parms.title, Parms.content, Parms.poster_id, Parms.topics);
  }
}

class UploadblogParms {
  final File image;
  final String title;
  final String content;
  final String poster_id;
  final List<String> topics;

  UploadblogParms(
      {required this.image,
      required this.title,
      required this.content,
      required this.poster_id,
      required this.topics});
}
