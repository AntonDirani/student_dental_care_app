import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../models/post_model.dart';
import '../resources/constants_manager.dart';
import 'package:http/http.dart' as http;

class PostController extends ChangeNotifier {
  List<Post> _posts = [];

  Future<bool> getPosts() async {
    try {
      print('some');
      var url = '${AppConstants.mainUrl}/show_posts';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);

      final List<String> loadedImages = [];

      List<String> ourImageArray = [];

      final List<Post> loadedPosts = [];

      for (int j = 0; j < data.length; j++) {
        final imageArray = data[j]['post_photos'] as List<dynamic>;

        List<String> loadedImages = []; // Initialize image list for each post

        for (int k = 0; k < imageArray.length; k++) {
          // Extracting the image URL from the innermost array
          List<dynamic> imageList = imageArray[k][0];
          String imageUrl = imageList[0];
          loadedImages.add('${AppConstants.mainUrl}/show_image/$imageUrl');
        }

        String firstDateTimeString = data[j]['first_date'];
        String secondDateTimeString = data[j]['last_date'];
        // Parse the string into a DateTime object
        DateTime firstDateTime = DateTime.parse(firstDateTimeString);
        DateTime lastDateTime = DateTime.parse(secondDateTimeString);
        // Extract the date in 'yyyy-MM-dd' format
        String date1 =
            "${firstDateTime.year}-${firstDateTime.month.toString().padLeft(2, '0')}-${firstDateTime.day.toString().padLeft(2, '0')}";

        // Extract the time in 'HH:mm' format
        String time1 =
            "${firstDateTime.hour.toString().padLeft(2, '0')}:${firstDateTime.minute.toString().padLeft(2, '0')}";

        String date2 =
            "${lastDateTime.year}-${lastDateTime.month.toString().padLeft(2, '0')}-${lastDateTime.day.toString().padLeft(2, '0')}";

        print(data[j]['post_id']);
        // Extract the time in 'HH:mm' format
        String time2 =
            "${lastDateTime.hour.toString().padLeft(2, '0')}:${lastDateTime.minute.toString().padLeft(2, '0')}";
        loadedPosts.add(Post(
            postId: data[j]['post_id'],
            postDescription: data[j]['description'],
            postImages: loadedImages,
            postFirstDate: date1,
            postFirstTime: time1,
            postLastDate: date2,
            postLastTime: time2,
            postStudentName: data[j]['student_name'],
            postAvgRate: data[j]['\$avg_rate'],
            postUniName: 'جامعة البعث',
            postTreatmentName: data[j]['treatment_name']));
      }

      _posts = loadedPosts;
      print(_posts);
      notifyListeners();
      /*unPackUnisNames(_unis);
      unPackUnisIds(_unis);*/
      // print(_unisNames);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Post>> getPostsList() async {
    notifyListeners();
    return _posts;
  }

  File? imageFile; // Store the downloaded image file

  Future<File?>? fetchImage() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/show_image/Screenshot_2023-08-16-23-46-12-088_com.google.android.youtube.jpg'));

    if (response.statusCode == 200) {
      final appDir = await getApplicationDocumentsDirectory();
      final filePath =
          '${appDir.path}/image.jpg'; // Change the extension if needed
      final file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);

      return file;
    } else {
      print('fail');
      return null;
    }
  }
}
