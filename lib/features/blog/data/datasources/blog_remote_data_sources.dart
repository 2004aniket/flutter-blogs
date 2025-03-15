import 'dart:io';

import 'package:blog/core/exceptions/serverexception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSources {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage(File image, BlogModel blog);
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourcesImpl implements BlogRemoteDataSources {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourcesImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final newBlog =
          await supabaseClient.from("blogs").insert(blog.toJson()).select();
      return BlogModel.fromJson(newBlog.first);
    } catch (e) {
      throw Serverexception(e.toString());
    }
  }

  @override
  Future<String> uploadImage(File image, BlogModel blog) async {
    try {
      await supabaseClient.storage.from("blog_images").upload(blog.id, image);

      return supabaseClient.storage.from("blog_images").getPublicUrl(blog.id);
    } catch (e) {
      throw Serverexception(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from("blogs").select("*,profiles(name)");

      return blogs
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } catch (e) {
      throw Serverexception(e.toString());
    }
  }
}
