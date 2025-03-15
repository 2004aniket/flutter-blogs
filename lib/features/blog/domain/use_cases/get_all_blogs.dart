import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

import '../entity/blog.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParms> {
  final BlogRepository blogRepository;

  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(Parms) async {
    return await blogRepository.getAllBlogs();
  }
}
