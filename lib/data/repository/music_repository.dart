import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/model/music_model.dart';

abstract class MusicRepository{
  Future<List<MusicModel>> musicCollection();
}

class MusicRepositoryImpl implements MusicRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<MusicModel>> musicCollection() async {
  return await _db.collection("MusicVideo")
        .get()
        .then(((value) => value.docs.map((e) => MusicModel.fromJson(e.data())).toList()))
        .catchError((error) {});
  }

}