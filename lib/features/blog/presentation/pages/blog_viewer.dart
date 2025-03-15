import 'package:blog/features/blog/domain/entity/blog.dart';
import 'package:flutter/material.dart';

class BlogViewer extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
      builder: (context) => BlogViewer(
            blog: blog,
          ));
  final Blog blog;
  const BlogViewer({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: const TextStyle(fontSize: 20),
              ),
              Text("by ${blog.poster_name!}"),
              Text(blog.updated_at.toString()),
              ClipRRect(
                  child: blog.image_url != null
                      ? Image.network(blog.image_url)
                      : Image.network(
                          "https://imgs.search.brave.com/x_rFDF8ZfdPz_ICvGjGYjzQkixSDbAaqZRn5_AQYR00/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy9i/L2I2L0ltYWdlX2Ny/ZWF0ZWRfd2l0aF9h/X21vYmlsZV9waG9u/ZS5wbmc")),
            ],
          ),
        ),
      ),
    );
  }
}
