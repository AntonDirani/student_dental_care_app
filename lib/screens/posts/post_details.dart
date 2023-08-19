import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/patient_controller.dart';
import 'package:student_care_app/controllers/report_controller.dart';
import 'package:student_care_app/models/report_model.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';

import '../../components/booking_dialog.dart';
import '../../models/post_model.dart';
import '../../resources/font_manager.dart';
import '../../student_details.dart';

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
  List<ReportItem> reportReasons = [
    /*'بيع أو شراء أو أي عملية تسويق لمنتج أو خدمة',
    'توجيه المستخدمين خارج التطبيق عن طريق استخدام روابط مضللة',
    'محتوى غير لائق أو غير أخلاقي',
    'نشر معلومات طبية خاطئة أو غير دقيقة',
    'نشر محتوى خارج نطاق طب الأسنان',
    // Add more reasons as needed*/
  ];
  void _showBookingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BookingDialog(postId: _myPost.postId!, post: _myPost);
      },
    );
  }

  @override
  void initState() {
    reportReasons =
        Provider.of<ReportController>(context, listen: false).reportItems;
    super.initState();
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'التبليغ على المنشور',
            style: StylesManager.semiBold18Primary(),
            textAlign: TextAlign.right,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'اختر احد الاسباب',
                style: StylesManager.semiBold17Black(),
                textAlign: TextAlign.right,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: reportReasons.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: Icon(
                      Icons.circle,
                      color: ColorManager.costumeBlack,
                      size: 10,
                    ),
                    title: Text(
                      reportReasons[index].reportItemName!,
                      style: StylesManager.medium16Black(),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return Consumer<PatientController>(
                            builder: (context, patientController, _) {
                              if (patientController.isApiInProgressReport) {
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
                              } else if (patientController
                                  .isApiSuccessfulReport) {
                                return Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'العودة',
                                              style: StylesManager
                                                  .semiBold16Primary(),
                                            )),
                                        Text(
                                          '!تمت العملية بنجاح',
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
                                          patientController.apiResponseReport,
                                          style: StylesManager.medium16Black(),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Close'),
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
                      await Provider.of<PatientController>(context,
                              listen: false)
                          .reportPost(
                              postId: _myPost.postId!,
                              reportId: reportReasons[index].reportItemId!);
                      print('Reporting for: ${reportReasons[index]}');
                      //    Navigator.pop(context); // Close the dialog
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleMenuItemClick(String option) {
    // Do something based on the selected option
    print('Selected option: $option');
    _showReportDialog(context);
    // You can perform any other actions here
  }

  void showPopup(BuildContext context) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.4,
        left: MediaQuery.of(context).size.width * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Material(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: ColorManager.lightGrey,
                //border: Border.all(color: ColorManager.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                )),
            child: Center(
              child: Text(
                'إزالة السن المصابة بشكل كامل',
                style: StylesManager.regular14Black(),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Automatically dismiss the popup after 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 17, 15),
          child: ComponentManager.mainGradientButton(
              text: "!احجز موعدك الآن",
              onPressed: () {
                _showBookingDialog(context);
              }),
        ),
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'option1',
                    child: Text(
                      '..التبليغ على هذا المنشور',
                      textAlign: TextAlign.right,
                      style: StylesManager.medium16Black(),
                    ),
                  ),
                  // Add more options as needed
                ];
              },
              onSelected: _handleMenuItemClick,
            ),
          ],
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
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Image.network(
                          i,
                          fit: BoxFit.cover,
                        ));
                  },
                );
              }).toList(),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageSliders.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : ColorManager.primary)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Container(
                        width: 55,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ColorManager.lightGrey,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showPopup(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    ImageAssetsManager.treatmentVector,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                              child: Text(
                                _myPost.postTreatmentName!,
                                style: TextStyle(
                                    fontFamily: FontConstants.fontFamily,
                                    fontSize: 14,
                                    color: ColorManager.costumeBlack),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentProfileScreen()),
                        );
                      },
                      child: Row(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 6, 10),
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
                                      const SizedBox(
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
                              color: ColorManager.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Divider(
                    thickness: 3,
                    color: ColorManager.lightGrey,
                  ),
                ),
              ],
            ),
            Column(
              children: [
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
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _myPost.postDescription!,
                      style: StylesManager.regular16Grey(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
            /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Divider(
                    thickness: 3,
                    color: ColorManager.lightGrey,
                  ),
                ),*/
          ]),
        ));
  }
}
