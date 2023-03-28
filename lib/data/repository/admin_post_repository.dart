import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/model/affirmation_model.dart';
import 'package:red_flag/model/music_model.dart';
import 'package:red_flag/model/our_stories_model.dart';
import 'package:red_flag/model/riddle_model.dart';
import 'package:red_flag/model/user_model.dart';

abstract class AdminPostRepository{
  Future<void> createStory({OurStoriesModel  ourStoriesModel});
  Future<void> createAffirmation({AffirmationModel affirmationModel});
  Future<void> createRiddle({RiddlesModel riddleModel});
  Future<void> createMusicVideo({MusicModel musicModel});
  Future<List<UserModel>> userData();
  Future createCommentsCollection({String? id});
}

class AdminPostRepositoryImpl implements AdminPostRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> createStory({OurStoriesModel? ourStoriesModel}) async {
     var result = await _db.collection("AdminPostsCollection").add(
      ourStoriesModel!.toJson()
    );
    await createCommentsCollection(id: result.id);
  await _db.collection("AdminPostsCollection").doc(result.id).update({"postId":result.id});
  }

 @override
  Future createCommentsCollection({String? id}) async {
    // CollectionReference post = 
    _db.collection("AdminPostsCollection").
    doc(id).collection("CommentsCollection");
  //  await _db.collection("PostsCollection").add(
  //   );  
    }

  @override
  Future<void> createAffirmation({AffirmationModel? affirmationModel}) async {
     var result = await _db.collection("Affirmation").add(
      affirmationModel!.toJson()
    );
  await _db.collection("Affirmation").doc(result.id).update({"postId":result.id});
  }

  @override
  Future<void> createMusicVideo({MusicModel? musicModel}) async {
   var result = await _db.collection("MusicVideo").add(
      musicModel!.toJson()
    );
  await _db.collection("MusicVideo").doc(result.id).update({"postId":result.id});
  }

  @override
  Future<void> createRiddle({RiddlesModel? riddleModel}) async {
    var result = await _db.collection("RiddleCollection").add(
      riddleModel!.toJson()
    );
  await _db.collection("RiddleCollection").doc(result.id).update({"id":result.id});
  }

  @override
  Future<List<UserModel>> userData() async {
      return await _db.collection("UserData")
        .get()
        .then(((value) => value.docs.map((e) => UserModel.fromJson(e.data())).toList()))
        .catchError((error) {});
  }
}