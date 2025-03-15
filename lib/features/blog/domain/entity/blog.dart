// ignore_for_file: non_constant_identifier_names

class Blog {
  final String id;
  final String title;
  final String content;
  final String image_url;
  final List<String> topics;
  final DateTime updated_at;
  final String poster_id;
  final String? poster_name;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.image_url,
    required this.topics,
    required this.updated_at,
    required this.poster_id,
    this.poster_name,
  });
}
