import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? details;
  int? postComments;
  String? postId;
  List<dynamic>? postLikes;
  String? postPicture;
  String? postTitle;
  bool? userAvatarMode;
  String? userId;
  String? userName;
  String? userProfile;
  String? timeStamp;
  final DocumentReference? reference;
  PostModel({
    this.details,
    this.postComments,
    this.postId,
    this.postLikes,
    this.postPicture,
    this.postTitle,
    this.userAvatarMode,
    this.userId,
    this.userName,
    this.userProfile,
    this.timeStamp,
    this.reference
  });
  PostModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
  : details = map['postDetails'],
        postComments = map['postComments'],
        postId = map['postId'],
        postLikes = map['postLikes'],
        postPicture = map['postPicture'],
        postTitle = map['postTitle'],
        userAvatarMode = map['userAvatarMode'],
        userId = map['userId'],
        userName = map['userName'],
        userProfile = map['userProfile'];

 PostModel.fromJson(Map<String, dynamic> map, {this.reference} )
      : details = map['postDetails'],
        postComments = map['postComments'],
        postId = map['postId'],
        postLikes = map['postLikes'],
        postPicture = map['postPicture'],
        postTitle = map['postTitle'],
        userAvatarMode = map['userAvatarMode'],
        userId = map['userId'],
        userName = map['userName'],
        timeStamp = map["timeStamp"],
        userProfile = map['userProfile'];
        

    Map<String, dynamic> toJson(){
        return {
          'postDetails' : details,
          'postComments' : postComments,
          'postId' : postId,
          'postLikes' : postLikes,
          'postPicture' : postPicture,
          'postTitle' : postTitle,
          'userAvatarMode' : userAvatarMode,
          'userId' : userId,
          'userName' : userName,
          'timeStamp' : timeStamp,
          'userProfile' : userProfile
        };
    }
  PostModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);
    
}