import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/model/our_stories_model.dart';

abstract class OurStoriesRepository {
  Future<List<OurStoriesModel>> getStories ();
}

class OurStoriesRepositoryImpl implements OurStoriesRepository{
    final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<OurStoriesModel>> getStories() async {
   return await _db.collection("AdminPostsCollection").orderBy("postCreated",descending: true)
        .get()
        .then(((value) => value.docs.map((e) => OurStoriesModel.fromJson(e.data())).toList()))
        .catchError((error) { 
        });
  }

}