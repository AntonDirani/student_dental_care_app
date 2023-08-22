// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:student_care_app/controllers/student_controller.dart';
import 'package:student_care_app/screens/posts/my_post_appointments.dart';

import '../models/post_model.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class MyPostList extends StatefulWidget {
  const MyPostList({
    super.key,
    required Future<List<Post>> posts,
  }) : _posts = posts;

  final Future<List<Post>> _posts;

  @override
  State<MyPostList> createState() => _MyPostListState(_posts);
}

class _MyPostListState extends State<MyPostList> {
  final Future<List<Post>> posts;
  //late Future<List<Post>> _loadedPosts; // Initialize it here

  _MyPostListState(this.posts);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentController>(
        builder: (context, studentController, child) {
      return FutureBuilder<List<Post>>(
          future: studentController.getMyPostsList(), // Use the provider here
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              // Existing code...
              List<Post> posts = snapshot.data!;
              return SizedBox(
                //width: 90.w,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  scrollDirection: Axis.vertical,
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostCard(post: posts[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                ).build(context),
              );
            } else if (snapshot.data!.isEmpty) {
              return CircularProgressIndicator();
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
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: ColorManager.red,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Consumer<StudentController>(
                      builder: (context, studentController, _) {
                        if (studentController.isApiInProgressDelete) {
                          return const Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          );
                        } else if (studentController.isApiSuccessfulDelete) {
                          return Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'العودة',
                                        style:
                                            StylesManager.semiBold16Primary(),
                                      )),
                                  Text(
                                    '!تم الحذف بنجاح',
                                    style: StylesManager.medium16Black(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'حدث خطأ ما',
                                    style: StylesManager.medium16Black(),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('العودة'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
                Provider.of<StudentController>(context, listen: false)
                    .deletePost(postId: post.postId!);
              },
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: GestureDetector(
              onTap: () async {
                await Provider.of<StudentController>(context, listen: false)
                    .getPostAppointments(post.postId!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => //PostDetails(post)
                          MyPostAppointments(
                            postID: post.postId!,
                          )),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  height: 35.h,
                  decoration: BoxDecoration(
                      color: ColorManager.lightGrey,
                      //border: Border.all(color: ColorManager.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            post.postImages![0],
                            fit: BoxFit
                                .cover, // Crop the image to fit while maintaining aspect ratio
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 8, 0),
                                      child: Text(
                                        post.postStudentName!,
                                        style: StylesManager.semiBold17Black(),
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            post.postUniName!,
                                            style:
                                                StylesManager.regular16Grey(),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(
                              thickness: 0.8,
                              height: 0,
                              color: ColorManager.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 5, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  //  values[index].postUniName!,
                                  '${post.postFirstDate}  /  ${post.postLastDate} ',
                                  style: StylesManager.semiBold16Primary(),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(
                                post.postDescription!,
                                style: StylesManager.regular16Grey(),
                                textAlign: TextAlign.start,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
