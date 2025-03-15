import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/domain/entity/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog(File image, String title,
      String content, String poster_id, List<String> topics);

  Future<Either<Failure, List<Blog>>> getAllBlogs();
  
}
