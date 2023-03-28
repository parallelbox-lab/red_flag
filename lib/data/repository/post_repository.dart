import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> postCollection();
  Future<List<PostModel>> getPostByUsers();
  Stream searchPostCollection({String? searchCases});
    Future createCommentsCollection({String? id, String? postOwnerId});
}
class PostRepositoryImpl implements PostRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<PostModel>> postCollection() async {
   return await _db.collection("PostsCollection").orderBy("timeStamp",descending: true)
        .get()
        .then(((value) => value.docs.map((e) => PostModel.fromJson(e.data())).toList()))
        .catchError((error) {});
  }

   Future<List<PostModel>> searchPost({String? query}) async {
   return await _db.collection("PostsCollection")
   .where("postDetails",isGreaterThanOrEqualTo: query)
   .where("postDetails", isLessThan: query !+ 'z')
        .get()
        .then(((value) => value.docs.map((e) => PostModel.fromJson(e.data())).toList()))
        .catchError((error) {print(error);});
  }

 @override
  Future<List<PostModel>> getPostByUsers() async {
   return await _db.collection("PostsCollection").where("userId",isEqualTo: UserData.getUserId()).orderBy("timeStamp",descending: true)
        .get()
        .then(((value) => value.docs.map((e) => PostModel.fromJson(e.data())).toList()))
        .catchError((error) {});
  }

  likeHandler({String? postId, List<dynamic>? likes}){

   DocumentReference doc = _db.collection("PostsCollection").doc(postId); 
   // <-- Doc ID where data should be updated.
    doc.update({'postLikes' :likes}) // <-- Updated data
    .catchError((error) { });
  }
  unLikeHandler({String? postId, List<dynamic>? likes}){
   DocumentReference doc = _db.collection("PostsCollection").doc(postId); 
   // <-- Doc ID where data should be updated.
    doc.update({'postLikes' :likes}) // <-- Updated data
    .catchError((error) {});
  }

  @override
  Stream searchPostCollection({String? searchCases}) async* {
   yield _db.collection("PostsCollection")
    // .where("postTitle", isGreaterThanOrEqualTo: searchCases)
    .where("details",isNotEqualTo:searchCases).orderBy("details").startAt([searchCases,])
    .snapshots();
              //       .endAt([searchtxt+'\uf8ff',])
    // .get()
    //     .then(((value) => value.docs.map((e) => PostModel.fromJson(e.data())).toList()))
    //     .catchError((error) {});
  }

  @override
  Future createCommentsCollection({String? id, String? postOwnerId,String? comment,String? addedTime}) async {
    final post = _db.collection("PostsCollection").
    doc(id).collection("CommentsCollection");
    final d = await post.add({
      "addedTime": addedTime,
      "postId": id,
      "postOwnerId":postOwnerId,
      "details":comment,
      "userId":UserData.getUserId(),
      "commentBy":UserData.fullName(),
      "userProfileImage":UserData.getUserProfilePic(),
    });
    await post.doc(d.id).update({
      "commentId":d.id,
    });
    }
}