import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';

import '../../models/post_model.dart';

class PostDetails extends StatefulWidget {
  const PostDetails(
    Post post, {
    super.key,
  }) : _post = post;

  final Post _post;

  @override
  State<PostDetails> createState() => _PostDetailsState(_post);
}

class _PostDetailsState extends State<PostDetails> {
  final Post _myPost;
  List<String> imageSliders = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  _PostDetailsState(this._myPost) {
    imageSliders = _myPost.postImages!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'تفاصيل المعالجة',
            style: StylesManager.medium18White(),
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  height: 185.0,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imageSliders.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Image.network(
                          i,
                          fit: BoxFit.cover,
                        ));
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageSliders.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : ColorManager.primary)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 8, 0),
                      child: Text(
                        //  values[index].postUniName!,
                        _myPost.postStudentName!,
                        style: StylesManager.medium19(),
                        //textAlign: TextAlign.right,
                        //  textDirection: TextDirection.rtl,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 6, 10),
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
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.person_outline,
                    size: 55,
                    color: ColorManager.lightSecondary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(
                thickness: 3,
                color: ColorManager.lightGrey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  //  values[index].postUniName!,
                  'معالجة لبية',
                  style: StylesManager.medium18Black(),
                  //textAlign: TextAlign.right,
                  //  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  width: 3,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 15.0, 5),
                  child: SvgPicture.asset(
                    ImageAssetsManager.treatmentVector,
                    color: ColorManager.primary,
                    height: 25,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'وصف المعالجة',
                  style: StylesManager.medium18Black(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                'وصف المعالجة هو كالإتي يجب ان تكتب بضعة اسطر عن نفسك او المعالجة اي شيئ يساعدك بالحصول على موعد',
                style: StylesManager.regular16Grey(),
                textAlign: TextAlign.right,
              ),
            )
          ]),
        ));
  }
}
