import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/model/questionaire_model.dart';

abstract class QuestionaireRepository {
  Future<List<QuestionaireModel>> fetchQuestions({String? question});
}

class QuestionaireRepositoryImpl implements QuestionaireRepository{
    final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<List<QuestionaireModel>> fetchQuestions({String? question}) async {
     return await _db.collection("QuestionCollection").
                doc("questions").collection(question ??  "")
        .get()
        .then(((value) => value.docs.map((e) => QuestionaireModel.fromJson(e.data())).toList()))
        .catchError((error) {});
  }

}