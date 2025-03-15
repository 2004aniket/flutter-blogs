import 'package:blog/core/utils/calculatereadingtime.dart';
import 'package:blog/features/blog/domain/entity/blog.dart';
import 'package:blog/features/blog/presentation/pages/blog_viewer.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewer.route(blog));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: blog.topics
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                label: Text(e),
                              ),
                            ))
                        .toList(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      blog.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${calculateReadingTime(blog.content)}m"),
            )
          ],
        ),
      ),
    );
  }
}
