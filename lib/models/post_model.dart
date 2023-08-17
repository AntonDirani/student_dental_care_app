class Post {
  int? postId;
  String? postDescription;
  String? postStudentName;
  int? postTreatmentId;
  List<String>? postImages;
  String? postTreatmentName;
  String? postUniName;
  int? postAvgRate;

  Post(
      {this.postAvgRate,
      this.postId,
      this.postDescription,
      this.postStudentName,
      this.postTreatmentId,
      this.postImages,
      this.postTreatmentName,
      this.postUniName});
}
