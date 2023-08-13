import 'dart:io';

class Post {
  int? postId;
  String? postDescription;
  String? postStudentName;
  int? postTreatmentId;
  File? postImage;
  String? postTreatmentName;
  String? postUniName;

  Post(
      {this.postId,
      this.postDescription,
      this.postStudentName,
      this.postTreatmentId,
      this.postImage,
      this.postTreatmentName,
      this.postUniName});
}
