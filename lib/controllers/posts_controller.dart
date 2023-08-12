import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';
import '../resources/constants_manager.dart';
import 'package:http/http.dart' as http;

class PostController extends ChangeNotifier {
  List<Post> _posts = [];
  Future<bool> getPosts() async {
    try {
      var url = '${AppConstants.mainUrl}/show_posts';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body) as List<dynamic>;
      final List<Post> loadedPosts = [];
      for (int j = 0; j < data.length; j++) {
        loadedPosts.add(Post(
            postDescription: data[j]['description'],
            postStudentName: data[j]['student_name'],
            treatmentName: data[j]['treatment_name']));
      }

      _posts = loadedPosts;
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
    return _posts;
  }
}
