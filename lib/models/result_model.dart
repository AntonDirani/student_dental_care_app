class Result {
  String? patientName;
  int? treatmentId;
  String? treatmentName;
  String? questionName;

  Result(
      {this.patientName,
      this.treatmentId,
      this.treatmentName,
      this.questionName});

  Result.fromJson(Map<String, dynamic> json) {
    patientName = json['patient_name'];
    treatmentId = json['treatment_id'];
    treatmentName = json['treatment_name'];
    questionName = json['question_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_name'] = this.patientName;
    data['treatment_id'] = this.treatmentId;
    data['treatment_name'] = this.treatmentName;
    data['question_name'] = this.questionName;
    return data;
  }
}
