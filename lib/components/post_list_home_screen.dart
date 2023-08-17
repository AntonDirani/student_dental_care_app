// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/screens/posts/post_details.dart';

import '../controllers/posts_controller.dart';
import '../models/post_model.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class PostList extends StatefulWidget {
  const PostList({
    super.key,
    required Future<List<Post>> posts,
  }) : _posts = posts;

  final Future<List<Post>> _posts;

  @override
  State<PostList> createState() => _PostListState(_posts);
}

class _PostListState extends State<PostList> {
  final Future<List<Post>> _posts;
  //late Future<List<Post>> _loadedPosts; // Initialize it here

  _PostListState(Future<List<Post>> posts) : _posts = posts;

  @override
  void initState() {
    super.initState();
    //_loadedPosts = _posts;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostController>(builder: (context, postController, child) {
      return FutureBuilder<List<Post>>(
          future: postController.getPostsList(), // Use the provider here
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              // Existing code...
              List<Post> posts = snapshot.data!;
              // Retrieve the stored treatment name from SharedPreferences
              Future<SharedPreferences> _prefs =
                  SharedPreferences.getInstance();
              Future<String?> _storedTreatmentName = _prefs.then((prefs) {
                return prefs.getString('treatmentName');
              });
              return SizedBox(
                height: 41.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetails(posts[index])),
                        );
                      },
                      child: PostCard(post: posts[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 10);
                  },
                ).build(context),
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    });
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      decoration: BoxDecoration(
          color: ColorManager.lightGrey,
          //border: Border.all(color: ColorManager.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Image.network(
                post.postImages![0],

                fit: BoxFit
                    .cover, // Crop the image to fit while maintaining aspect ratio
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.star,
                                size: 25,
                                color: ColorManager.star,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                post.postAvgRate!.toString(),
                                style: StylesManager.bold18Black(),
                                //textAlign: TextAlign.right,
                                //  textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
                          child: Text(
                            post.postStudentName!,
                            style: StylesManager.semiBold17Black(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                post.postUniName!,
                                style: StylesManager.regular16Grey(),
                                //textAlign: TextAlign.right,
                                //  textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.location_on,
                                size: 15,
                                color: ColorManager.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  thickness: 0.8,
                  height: 0,
                  color: ColorManager.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      //  values[index].postUniName!,
                      'الاثنين - الخميس',
                      style: StylesManager.medium14Primary(),
                      //textAlign: TextAlign.right,
                      //  textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.calendar_month,
                      size: 15,
                      color: ColorManager.primary,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text(
                    post.postDescription!,
                    style: StylesManager.regular16Grey(),
                    textAlign: TextAlign.end,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
