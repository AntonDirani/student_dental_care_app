// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import '../../models/post_model.dart';
// import '../../resources/color_manager.dart';
// import '../../resources/styles_manager.dart';

// class PostCard extends StatelessWidget {
//   const PostCard({
//     super.key,
//     required this.post,
//   });

//   final Post post;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(16),
//         topRight: Radius.circular(16),
//       ),
//       child: Container(
//         width: 77.w,
//         decoration: BoxDecoration(
//             color: ColorManager.lightGrey,
//             //border: Border.all(color: ColorManager.grey),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(10),
//             )),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 child: Image.network(
//                   post.postImages![0],

//                   fit: BoxFit
//                       .cover, // Crop the image to fit while maintaining aspect ratio
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Icon(
//                                   Icons.star,
//                                   size: 25,
//                                   color: ColorManager.star,
//                                 ),
//                                 const SizedBox(
//                                   width: 3,
//                                 ),
//                                 Text(
//                                   post.postAvgRate!.toString(),
//                                   style: StylesManager.bold18Black(),
//                                   //textAlign: TextAlign.right,
//                                   //  textDirection: TextDirection.rtl,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 7,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
//                             child: Text(
//                               post.postStudentName!,
//                               style: StylesManager.semiBold17Black(),
//                               textAlign: TextAlign.right,
//                               textDirection: TextDirection.rtl,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 5, 3),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   post.postUniName!,
//                                   style: StylesManager.regular16Grey(),
//                                   //textAlign: TextAlign.right,
//                                   //  textDirection: TextDirection.rtl,
//                                 ),
//                                 SizedBox(
//                                   width: 3,
//                                 ),
//                                 Icon(
//                                   Icons.location_on,
//                                   size: 15,
//                                   color: ColorManager.grey,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Divider(
//                     thickness: 0.8,
//                     height: 0,
//                     color: ColorManager.grey,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 8, 5, 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         //  values[index].postUniName!,
//                         '${post.postFirstDate}  /  ${post.postLastDate} ',
//                         style: StylesManager.semiBold16Primary(),
//                         //textAlign: TextAlign.right,
//                         //  textDirection: TextDirection.rtl,
//                       ),
//                       const SizedBox(
//                         width: 3,
//                       ),
//                       Icon(
//                         Icons.calendar_month,
//                         size: 15,
//                         color: ColorManager.primary,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//                     child: Text(
//                       post.postDescription!,
//                       style: StylesManager.regular16Grey(),
//                       textAlign: TextAlign.end,
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
