part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSucess extends BlogState {}

final class BlogFetchSucess extends BlogState {
  final List<Blog> blogs;

  BlogFetchSucess({required this.blogs});
}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}
