// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/screens/posts/post_details.dart';

import '../models/post_model.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class PostList extends StatelessWidget {
  const PostList({
    super.key,
    required Future<List<Post>> posts,
  }) : _posts = posts;

  final Future<List<Post>> _posts;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _posts, // your async method that returns a future
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Post> values = snapshot.data;
          print(values);
          // if data is loaded
          return SizedBox(
            height: 41.h,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: values.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostDetails()),
                    );
                  },
                  child: Container(
                    width: 28.h,
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
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.asset(ImageAssetsManager.postImage),
                        ),
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
                                          //  values[index].postUniName!,
                                          '4.3',
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
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5),
                                    child: Text(
                                      values[index].postStudentName!,
                                      style: StylesManager.semiBold17Black(),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          //  values[index].postUniName!,
                                          'جامعة دمشق',
                                          style: StylesManager.regular14Grey(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Divider(
                            thickness: 1.2,
                            height: 6,
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
                          padding: const EdgeInsets.fromLTRB(0, 8, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                //  values[index].postUniName!,
                                '11:00 - 14:00',
                                style: StylesManager.medium14Primary(),
                                //textAlign: TextAlign.right,
                                //  textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.alarm,
                                size: 15,
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                        ),
                        /*Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            child: Text(
                              'أنا طالب طب أسنان في السنة الثالثة، وأحب دراسة تشخيص تسوس الأسنان وعلاجها.',
                              style: StylesManager.regular14Grey(),
                              textAlign: TextAlign.end,
                            ))*/
                      ],
                    ),
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
          return const CircularProgressIndicator();
        } else {
          // if data not loaded yet
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
