import 'dart:io';

class Post {
  int? postId;
  String? postDescription;
  String? postStudentName;
  int? treatmentId;
  File? postImage;
  String? treatmentName;

  Post(
      {this.postId,
      this.postDescription,
      this.postStudentName,
      this.treatmentId,
      this.postImage,
      this.treatmentName});
}
