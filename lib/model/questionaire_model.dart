class QuestionaireModel {
  String? question;
  List<Answers>? answers;
  bool? isLocked;
  
  QuestionaireModel({
    this.answers,
    this.question,
    this.isLocked
  });

  QuestionaireModel.fromJson(Map<dynamic, dynamic> map,){
   question = map['question'];
     if (map['answers'] != null) {
      answers = <Answers>[];
      map['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }}

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['question'] = question;
     if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    } 
    return data; 
  }
}

class Answers {
  String? description;
  int? impact;
  Answers({
    this.description,
    this.impact
  });

Answers.fromJson(Map<String, dynamic> json) {
    description= json['description'];
    impact = json['impact'];
}
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['impact'] = impact;
    return data;
   }
}