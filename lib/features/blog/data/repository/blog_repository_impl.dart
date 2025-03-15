import 'dart:io';

import 'package:blog/core/error/failure.dart';
// import 'package:blog/core/network/NetworkChecker.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_sources.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:blog/features/blog/domain/entity/blog.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSources blogRemoteDataSources;
  // final NetWorkChecker netWorkChecker;
  BlogRepositoryImpl({required this.blogRemoteDataSources});

  @override
  Future<Either<Failure, Blog>> uploadBlog(File image, String title,
      String content, String poster_id, List<String> topics) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          title: title,
          content: content,
          image_url: '',
          topics: topics,
          updated_at: DateTime.now(),
          poster_id: poster_id);

      final imageUrl =
          await blogRemoteDataSources.uploadImage(image, blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedblog = await blogRemoteDataSources.uploadBlog(blogModel);

      return Right(uploadedblog);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      // if (await netWorkChecker.isConntected) {
      //   return Left(Failure("no Internet Connection"));
      // }
      final res = await blogRemoteDataSources.getAllBlogs();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
