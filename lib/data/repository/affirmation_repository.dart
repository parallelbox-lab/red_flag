import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/model/affirmation_model.dart';

abstract class AffirmationRepository{
  Future<List<AffirmationModel>> affirmationCollection();
}

class AffirmationRepositoryImpl implements AffirmationRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<AffirmationModel>> affirmationCollection()async {
   return await _db.collection("Affirmation")
        .get()
        .then(((value) => value.docs.map((e) => AffirmationModel.fromJson(e.data())).toList()))
        .catchError((error) {});
  }

}