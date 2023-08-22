import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/components/home_screen_drawer.dart';
import 'package:student_care_app/components/home_screen_student_drawer.dart';
import 'package:student_care_app/controllers/posts_controller.dart';
import 'package:student_care_app/controllers/student_controller.dart';
import 'package:student_care_app/controllers/treatment_controller.dart';
import 'package:student_care_app/models/treatment_model.dart';

import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/font_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:student_care_app/screens/posts/add_post_screen.dart';

import '../../components/post_list_home_screen.dart';
import '../../components/search_bar.dart';
import '../../controllers/location_controller.dart';
import '../../models/location_model.dart';
import '../../models/post_model.dart';
import '../../models/student_model.dart';
import '../posts/post_details.dart';

class HomeScreenStudent extends StatefulWidget {
  @override
  State<HomeScreenStudent> createState() => _HomeScreenStudentState();
}

late Future<List<Governorate>> _dropDownLocations;

class _HomeScreenStudentState extends State<HomeScreenStudent> {
  late final int index;
  late List<Treatment> treatments;
  late final Treatment treatment;
  late Future<List<Governorate>> _dropDownLocations;
  late Governorate _valueLocation;
  /*late final Future<Student> _student;*/
  @override
  void initState() {
    Provider.of<StudentController>(context, listen: false).getStudentProfile();
    /*  _student =
        Provider.of<StudentController>(context, listen: false).getStudent();*/
    _dropDownLocations = Provider.of<LocationController>(context, listen: false)
        .getLocationsList();
    _dropDownLocations.then((locations) {
      setState(() {
        _valueLocation = locations[0]; // Initialize with the first item
      });
    });
    super.initState();
  }

  void filterByLocation() {}

  //Governorate? _valueLocation = _values[0];
  int? _dropDownValue1Location;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()),
            );
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: FutureBuilder<List<Governorate>>(
              future: _dropDownLocations,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Governorate> _values = snapshot.data;
                  // Remove this line: Governorate? _valueLocation = _values[0];
                  // if data is loaded
                  return DropdownButton(
                    value: _valueLocation,
                    style: StylesManager.medium16Black(),
                    underline: const SizedBox(),
                    dropdownColor: ColorManager.lightGrey,
                    iconEnabledColor: ColorManager.costumeBlack,
                    items: _values.map<DropdownMenuItem<Governorate>>(
                      (Governorate location) {
                        return DropdownMenuItem<Governorate>(
                          value: location,
                          child: Text(location.governorateName.toString()),
                        );
                      },
                    ).toList(),
                    onChanged: (Governorate? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        _valueLocation = value!; // Update the selected value
                        print(_valueLocation.governorateId);
                      });
                    },
                  );
                } else {
                  // if data not loaded yet
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          iconTheme: const IconThemeData(
            size: 40, //change size on your need
            color: const Color(0xff242837),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        endDrawer: HomeScreenStudentDrawer(/*_student*/),
        body: HomeScreenBody(),
      ),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  late Future<List<Treatment>> _treatments;
  late Future<List<Post>> _posts;

  String query = '';

  Widget SearchBar() => SearchWidget(
        text: query,
        hintText: 'ابحث عن طالب هنا...',
        onChanged: searchBarFun,
      );

  Future<void> searchBarFun(String query) async {
    print('query');
    await Provider.of<StudentController>(context, listen: false)
        .getStudentsByName(query);
    setState(() {
      this.query = query;
    });
  }

  List<Post> _search(List<Post>? post) {
    if (_selectedTreatmentName.isNotEmpty == true) {
      //search logic what you want
      return post
              ?.where((element) =>
                  element.postTreatmentName!.contains(_selectedTreatmentName))
              .toList() ??
          <Post>[];
    }

    return post ?? <Post>[];
  }

  String _selectedTreatmentName = '';
  @override
  void initState() {
    _treatments = Provider.of<TreatmentController>(context, listen: false)
        .getTreatmentsList();

    // Get the initial list of posts, no need to use setState here
    _posts = Provider.of<PostController>(context, listen: false).getPostsList();
    Provider.of<StudentController>(context, listen: false).getMyPosts();

    super.initState();
  }

  Future<void> _refreshList() async {
    await Provider.of<StudentController>(context, listen: false)
        .getStudentProfile();
    final postController = Provider.of<PostController>(context, listen: false);
    Provider.of<StudentController>(context, listen: false).getMyPosts();
    // Fetch the updated posts
    await postController.getPosts();

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
      return RefreshIndicator(
        onRefresh: _refreshList,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 5),
                        child: Text(
                          'الحالات الطبية',
                          style: StylesManager.medium18Black(),
                        ),
                      ),
                      FutureBuilder<List<Treatment>>(
                        future:
                            _treatments, // Replace with your future method that fetches treatments
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Treatment>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Text('No data available.');
                          } else {
                            List<Treatment> treatments = snapshot.data!;
                            return SizedBox(
                              height: 150,
                              child: ListView.separated(
                                reverse: true,
                                padding: EdgeInsets.all(8.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: treatments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final treatment = treatments[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      // Store the selected treatment name using SharedPreferences
                                      _selectedTreatmentName =
                                          treatment.treatmentName!;

                                      setState(() {
                                        treatments.forEach((treatment) {
                                          treatment.isSelected = false;
                                        });
                                        treatment.isSelected = true;
                                      });
                                    },
                                    child: Container(
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: treatment.isSelected ?? false
                                            ? Colors.blue
                                            : ColorManager.lightGrey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                treatment.treatmentImage!,
                                                //width: 40,
                                                color: treatment.isSelected ??
                                                        false
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                3, 0, 3, 6),
                                            child: Text(
                                              treatment.treatmentName!,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontConstants.fontFamily,
                                                fontSize: 14,
                                                color: treatment.isSelected ??
                                                        false
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 10);
                                },
                              ),
                            );
                          }
                        },
                      ),
                      SearchBar(),
                      query.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 15, 5),
                                  child: Text(
                                    'الحالية',
                                    style: StylesManager.medium18Black(),
                                  ),
                                ),
                                Consumer<StudentController>(builder:
                                    (context, studentController, child) {
                                  return FutureBuilder<List<Student>>(
                                      future: studentController
                                          .getStudentsByNameList(), // Use the provider here
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<Student>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          // Existing code...
                                          List<Student> students =
                                              snapshot.data!;
                                          //
                                          return SizedBox(
                                            height: 41.h,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 10, 10, 10),
                                              scrollDirection: Axis.vertical,
                                              reverse: true,
                                              itemCount: students.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    print(students[index]);
                                                    /*Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostDetails(
                                                                  students[
                                                                      index])),
                                                    );*/
                                                  },
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    color:
                                                        ColorManager.lightGrey,
                                                    elevation: 0.5,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    child: ListTile(
                                                      trailing: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      title: Text(
                                                        students[index]
                                                            .studentName!,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: StylesManager
                                                            .medium17Black(),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                    width: 10);
                                              },
                                            ).build(context),
                                          );
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      });
                                }),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 15, 5),
                                  child: Text(
                                    'المعالجات الحالية',
                                    style: StylesManager.medium18Black(),
                                  ),
                                ),
                                Consumer<PostController>(
                                    builder: (context, postController, child) {
                                  return FutureBuilder<List<Post>>(
                                      future: postController
                                          .getPostsList(), // Use the provider here
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<Post>> snapshot) {
                                        if (snapshot.hasData) {
                                          // Existing code...
                                          List<Post> posts = snapshot.data!;
                                          final result = _search(snapshot.data);
                                          //
                                          return SizedBox(
                                            height: 41.h,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 10, 10, 10),
                                              scrollDirection: Axis.horizontal,
                                              reverse: true,
                                              itemCount: result.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    print(result[index]);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostDetails(
                                                                  result[
                                                                      index])),
                                                    );
                                                  },
                                                  child: PostCard(
                                                      post: result[index]),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                    width: 10);
                                              },
                                            ).build(context),
                                          );
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      });
                                }),
                              ],
                            )
                      /* PostList(posts: _posts)*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        width: 77.w,
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
                      flex: 2,
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
                      flex: 7,
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
      ),
    );
  }
}
