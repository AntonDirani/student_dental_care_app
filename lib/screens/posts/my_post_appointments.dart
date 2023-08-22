import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/models/appointment_model.dart';

import '../../controllers/student_controller.dart';
import '../../models/post_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import 'my_appointments_list.dart';

class MyPostAppointments extends StatefulWidget {
  const MyPostAppointments({
    super.key,
    required int postID,
  }) : _postId = postID;
  final int _postId;

  @override
  State<MyPostAppointments> createState() => _MyPostAppointmentsState(_postId);
}

class _MyPostAppointmentsState extends State<MyPostAppointments> {
  _MyPostAppointmentsState(int postID) : _postId = postID;

  late int _postId;
  late Future<List<Appointment>> _myAppointments;
  @override
  void initState() {
    _myAppointments = Provider.of<StudentController>(context, listen: false)
        .getCurrentPostAppointmentsList();

    super.initState();
  }

  Future<void> _refreshList() async {
    await Provider.of<StudentController>(context, listen: false)
        .getPostAppointments(_postId);
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
              'مواعيدي',
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MyAppointmentsList(appointments: _myAppointments)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )));
    });
  }
}
