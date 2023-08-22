class Question {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? question;
  int? questionId;
  int? leftChild;
  int? rightChild;
  String? icon;

  Question({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.question,
    this.questionId,
    this.leftChild,
    this.rightChild,
    this.icon,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    question = json['question'];
    questionId = json['question_id'];
    leftChild = json['left_child'];
    rightChild = json['right_child'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['question'] = question;
    data['question_id'] = questionId;
    data['left_child'] = leftChild;
    data['right_child'] = rightChild;
    data['icon'] = icon;
    return data;
  }
}
