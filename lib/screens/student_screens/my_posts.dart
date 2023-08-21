import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/student_controller.dart';

import '../../components/my_posts_list.dart';

import '../../models/post_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class StudentMyPosts extends StatefulWidget {
  const StudentMyPosts({super.key});

  @override
  State<StudentMyPosts> createState() => _StudentMyPostsState();
}

class _StudentMyPostsState extends State<StudentMyPosts> {
  late Future<List<Post>> _myPosts;
  @override
  void initState() {
    _myPosts =
        Provider.of<StudentController>(context, listen: false).getMyPostsList();

    super.initState();
  }

  Future<void> _refreshList() async {
    final studentController =
        Provider.of<StudentController>(context, listen: false);

    // Fetch the updated posts
    await studentController.getMyPosts();

    // Now that the posts are updated, trigger a rebuild of the widget
    setState(() {});

    // Show a snack-bar or toast to inform the user that the refresh is complete
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: ColorManager.primary,
          content: Text(
            '!تم التحديث',
            style: StylesManager.medium16White(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              'منشوراتي',
              style: StylesManager.medium18White(),
            ),
          ),
          body: RefreshIndicator(
              onRefresh: _refreshList,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [MyPostList(posts: _myPosts)],
                      ),
                    ),
                  ],
                ),
              )));
    });
  }
}
