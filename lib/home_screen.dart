import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:student_care_app/components/home_screen_drawer.dart';
import 'package:student_care_app/controllers/posts_controller.dart';
import 'package:student_care_app/controllers/treatment_controller.dart';
import 'package:student_care_app/models/treatment_model.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:student_care_app/screens/profiles/patient_profile.dart';
import 'components/search_bar.dart';
import 'controllers/location_controller.dart';
import 'models/location_model.dart';
import 'models/post_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Governorate> _dropDownLocations = [
  Governorate(governorateId: 4, governorateName: 'ريف دمشق')
];

class _HomeScreenState extends State<HomeScreen> {
  late final int index;
  late List<Treatment> treatments;
  late final Treatment treatment;
  @override
  void initState() {
    _dropDownLocations.addAll(
        Provider.of<LocationController>(context, listen: false).locations);
    ;
    super.initState();
  }

  Governorate? _valueLocation = _dropDownLocations[0];
  int? _dropDownValue1Location;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            child: DropdownButton(
                value: _valueLocation,
                style: StylesManager.medium16Black(),
                underline: const SizedBox(),
                dropdownColor: ColorManager.lightGrey,
                iconEnabledColor: ColorManager.costumeBlack,
                items: _dropDownLocations
                    .map<DropdownMenuItem<Governorate>>((Governorate location) {
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
                }),
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

  @override
  void initState() {
    _treatments = Provider.of<TreatmentController>(context, listen: false)
        .getTreatmentsList();
    _posts = Provider.of<PostController>(context, listen: false).getPostsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                FutureBuilder<List>(
                  future:
                      _treatments, // your async method that returns a future
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Treatment> values = snapshot.data;
                      // if data is loaded
                      return SizedBox(
                        height: 150,
                        child: ListView.separated(
                          padding: EdgeInsets.all(8.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 70,
                              decoration: BoxDecoration(
                                  color: ColorManager.lightGrey,
                                  //border: Border.all(color: ColorManager.grey),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        values[index].treatmentImage!,
                                        //height: 45,
                                        width: 40),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 90,
                                  ),
                                  Text(
                                    values[index].treatmentName!,
                                    style: StylesManager.regular14Black(),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 10);
                          },
                        ).build(context),
                      );
                    } else {
                      // if data not loaded yet
                      return CircularProgressIndicator();
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
                FutureBuilder<List>(
                  future: _posts, // your async method that returns a future
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Post> values = snapshot.data;
                      print(values);
                      // if data is loaded
                      return SizedBox(
                        height: 300,
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 270,
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                        ImageAssetsManager.postImage),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      values[index].postStudentName!,
                                      style: StylesManager.semiBold17Black(),
                                      //textAlign: TextAlign.right,
                                      //  textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 10);
                          },
                        ).build(context),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return CircularProgressIndicator();
                    } else {
                      // if data not loaded yet
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
