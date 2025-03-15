import 'package:blog/core/color_pallete.dart';
import 'package:blog/core/common/loader.dart';
import 'package:blog/core/common/showsnackbar.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/add_blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<BlogBloc>().add(GetFetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Blog App"),
        ),
        actions: [
          GestureDetector(
            child: const Icon(CupertinoIcons.add_circled),
            onTap: () {
              Navigator.push(context, AddBlogPage.route());
            },
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            print(state.message);
            showshackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogFetchSucess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  print("iamge ${blog.image_url}");
                  return BlogCard(
                      blog: blog,
                      color: index % 3 == 0
                          ? color_pallete.gradient1
                          : index % 3 == 1
                              ? color_pallete.gradient2
                              : color_pallete.gradient3);
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
