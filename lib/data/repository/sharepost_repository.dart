import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/model/post_model.dart';

abstract class SharePostRepository{
  Future createSharePost({PostModel? sharePostModel});
  // Future createCommentsCollection({String? id});
}

class SharePostRepositoryImpl implements SharePostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future createSharePost({PostModel? sharePostModel}) async {
  var result = await _db.collection("PostsCollection").add(
      sharePostModel!.toJson()
    );
  await _db.collection("PostsCollection").doc(result.id).update({"postId":result.id});
 }
 

}