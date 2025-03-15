import 'dart:io';

import 'package:blog/core/color_pallete.dart';
import 'package:blog/core/common/loader.dart';
import 'package:blog/core/cubits/AppUser/app_user_cubit.dart';
import 'package:blog/core/utils/pickImage.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/showsnackbar.dart';

class AddBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());

  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final List<String> selectedTopic = [];
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController contentEditingController =
      TextEditingController();
  final formkey = GlobalKey<FormState>();
  File? image;
  void selectImage() async {
    final selectimage = await PickImage();
    if (selectimage != null) {
      setState(() {
        image = selectimage;
      });
    }
  }

  void _onUpload() {
    final poster_id =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    if (formkey.currentState!.validate() &&
        selectedTopic.isNotEmpty &&
        image != null) {
      context.read<BlogBloc>().add(blogUpload(
          image: image!,
          title: titleEditingController.text.trim(),
          content: contentEditingController.text.trim(),
          poster_id: poster_id,
          topics: selectedTopic));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleEditingController.dispose();
    contentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Add Blog"),
        ),
        actions: [
          GestureDetector(
            onTap: _onUpload,
            child: const Icon(CupertinoIcons.check_mark_circled),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showshackbar(context, state.message);
            } else if (state is BlogUploadSucess) {
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    image != null
                        ? SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Image.file(
                              image!,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: color_pallete.borderColor)),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.folder_circle,
                                      size: 30,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Select The Image",
                                      style: TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Tech",
                          "Programming",
                          "Entertainment",
                          "Social",
                        ]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedTopic.contains(e)) {
                                          selectedTopic.remove(e);
                                        } else {
                                          selectedTopic.add(e);
                                        }
                                      });
                                    },
                                    child: Chip(
                                      label: Text(e),
                                      color: selectedTopic.contains(e)
                                          ? const WidgetStatePropertyAll(
                                              color_pallete.gradient1)
                                          : const WidgetStatePropertyAll(
                                              color_pallete.backgroundColor),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogFields(
                        controller: titleEditingController,
                        hintText: "Blog Title"),
                    const SizedBox(
                      height: 5,
                    ),
                    BlogFields(
                        controller: contentEditingController,
                        hintText: "Blog Content"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
