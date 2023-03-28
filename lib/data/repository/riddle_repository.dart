import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/model/riddle_model.dart';

abstract class RiddleRepository{
  Future<List<RiddlesModel>> riddleCollections();
}

class RiddleRepositoryImpl implements RiddleRepository{
 final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<RiddlesModel>> riddleCollections() async {
    return await _db.collection("RiddleCollection")
        .get()
        .then(((value) => value.docs.map((e) => RiddlesModel.fromJson(e.data())).toList()))
        .catchError((error) {});
  }

}