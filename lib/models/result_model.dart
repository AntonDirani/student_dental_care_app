class Result {
  String? patientName;
  String? treatmentName;

  Result({this.patientName, this.treatmentName});

  Result.fromJson(Map<String, dynamic> json) {
    patientName = json['patient_name'];
    treatmentName = json['treatment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_name'] = patientName;
    data['treatment_name'] = treatmentName;
    return data;
  }
}
