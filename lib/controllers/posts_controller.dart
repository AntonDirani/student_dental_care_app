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

        loadedPosts.add(Post(
            postDescription: data[j]['description'],
            postImages: loadedImages,
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
