class RiddlesModel {
  String? question;
  String? postImage;
  List<Answers>? answers;
  bool? isLocked;
  
  RiddlesModel({
    this.answers,
    this.question,
    this.isLocked,
    this.postImage
  });

  RiddlesModel.fromJson(Map<dynamic, dynamic> map,){
   question = map['question'];
   postImage = map['postImage'];
     if (map['answers'] != null) {
      answers = <Answers>[];
      map['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }}

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['question'] = question;
    data['postImage'] = postImage;
     if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    } 
    return data; 
  }
}

class Answers {
  String? description;
  bool? correctAns;
  Answers({
    this.description,
    this.correctAns
  });

Answers.fromJson(Map<String, dynamic> json) {
    description= json['description'];
    correctAns = json['correctAns'];
}
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['correctAns'] = correctAns;
    return data;
   }
}