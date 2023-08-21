import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/components/home_screen_drawer.dart';
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

class HomeScreenStudent extends StatefulWidget {
  @override
  State<HomeScreenStudent> createState() => _HomeScreenStudentState();
}

late Future<List<Governorate>> _dropDownLocations;

class _HomeScreenStudentState extends State<HomeScreenStudent> {
  late final int index;
  late List<Treatment> treatments;
  late final Treatment treatment;
  @override
  void initState() {
    _dropDownLocations = Provider.of<LocationController>(context, listen: false)
        .getLocationsList();
    super.initState();
  }

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
          /* leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientProfile()),
                  );
                },
                child: Image.asset(ImageAssetsManager.profileImage)),
          ),*/
          /*actions: [

          ],*/
          centerTitle: true,
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: FutureBuilder<List<Governorate>>(
              future:
                  _dropDownLocations, // your async method that returns a future
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Governorate> _values = snapshot.data;
                  Governorate? _valueLocation = _values[0];
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
                      }).toList(),
                      onChanged: (Governorate? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          _dropDownValue1Location = value?.governorateId;
                          _valueLocation = value;
                        });
                      });
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
        endDrawer: HomeScreenDrawer(),
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

  /*Future<List<Post>> fetchPosts() async {
    return _posts;
  }*/

  Widget SearchBar() => SearchWidget(
        text: query,
        hintText: 'ابحث عن طالب هنا...',
        onChanged: searchNews,
      );

  void searchNews(String query) {
    print('search');
    /*final news =
  Provider.of<NewsAPI>(context, listen: false).allNews.where((news) {
    final nameLower = news.head?.toLowerCase();
    final searchLower = query.toLowerCase();

    return nameLower!.contains(searchLower);
  }).toList();

  setState(() {
    this.query = query;
    this.news = news;
  });*/
  }

  late String _selectedTreatmentName = '';
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
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString('selectedTreatment',
                                          treatment.treatmentName!);
                                      print(treatment.treatmentName);
                                      print(
                                          prefs.getString('selectedTreatment'));

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
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              treatment.treatmentImage!,
                                              width: 40,
                                              color:
                                                  treatment.isSelected ?? false
                                                      ? Colors.white
                                                      : null,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                90,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 15, 5),
                        child: Text(
                          'المعالجات الحالية',
                          style: StylesManager.medium18Black(),
                        ),
                      ),
                      PostList(posts: _posts)
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
