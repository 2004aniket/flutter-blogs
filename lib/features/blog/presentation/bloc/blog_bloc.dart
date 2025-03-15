import 'dart:io';

import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/use_cases/UploadBlog.dart';
import 'package:blog/features/blog/domain/use_cases/get_all_blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final Uploadblog _uploadblog;
  final GetAllBlogs _allBlogs;
  BlogBloc({required Uploadblog uploadblog, required GetAllBlogs getallblog})
      : _uploadblog = uploadblog,
        _allBlogs = getallblog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<blogUpload>(_emitbloguploadSucess);
    on<GetFetchAllBlogs>(_emitfetechblogSucess);
  }

  void _emitbloguploadSucess(blogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadblog(UploadblogParms(
        image: event.image,
        title: event.title,
        content: event.content,
        poster_id: event.poster_id,
        topics: event.topics));

    res.fold((l) => emit(BlogFailure(message: l.message)),
        (r) => emit(BlogUploadSucess()));
  }

  void _emitfetechblogSucess(
      GetFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _allBlogs(NoParms());

    res.fold((l) => emit(BlogFailure(message: l.message)),
        (r) => emit(BlogFetchSucess(blogs: r)));
  }
}
