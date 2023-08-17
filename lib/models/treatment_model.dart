class Treatment {
  int? treatmentId;
  String? treatmentImage;
  String? treatmentName;
  String? treatmentIcon;
  String? treatmentDescription;
  bool? isSelected;

  Treatment(
      {this.treatmentId,
      this.treatmentDescription,
      this.treatmentImage,
      this.treatmentName,
      this.treatmentIcon,
      this.isSelected});
}
