class Post {
  int? postId;
  String? postDescription;
  String? postStudentName;
  int? postTreatmentId;
  List<String>? postImages;
  String? postTreatmentName;
  String? postUniName;
  String? postFirstTime;
  String? postLastTime;
  String? postFirstDate;
  String? postLastDate;
  String? postTreatmentDescription;
  int? postAvgRate;

  Post(
      {this.postTreatmentDescription,
      this.postFirstDate,
      this.postFirstTime,
      this.postLastDate,
      this.postLastTime,
      this.postAvgRate,
      this.postId,
      this.postDescription,
      this.postStudentName,
      //this.postTreatmentId,
      this.postImages,
      this.postTreatmentName,
      this.postUniName});
}
