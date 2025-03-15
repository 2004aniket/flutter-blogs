part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class blogUpload extends BlogEvent {
  final File image;
  final String title;
  final String content;
  final String poster_id;
  final List<String> topics;

  blogUpload(
      {required this.image,
      required this.title,
      required this.content,
      required this.poster_id,
      required this.topics});
}

final class GetFetchAllBlogs extends BlogEvent {}
