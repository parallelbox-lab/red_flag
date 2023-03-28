import 'package:cloud_firestore/cloud_firestore.dart';

class OurStoriesModel{
  int? postComments;
  dynamic postCreated;
  String? postDetails;
  String? postId;
  List<dynamic>? postLikes;
  String? postPicture;
  String? postTitle;
  String? userId;
  String? userName;
  String? userProfilePicture;
  final DocumentReference? reference;


  OurStoriesModel({
    this.postComments,
    this.postCreated,
    this.postDetails,
    this.postId,
    this.postLikes,
    this.postPicture,
    this.postTitle,
    this.userId,
    this.userName,
    this.userProfilePicture,
    this.reference
  });

  OurStoriesModel.fromJson(Map<String, dynamic> map, {this.reference} )
      : postComments = map["postComments"],
        postCreated = map["postCreated"],
        postDetails = map['postDetails'],
        postId = map["postId"],
        postLikes = map['postLikes'],
        postPicture = map['postPicture'],
        postTitle = map['postTitle'],
        userId = map['userId'],
        userName = map['userName'],
        userProfilePicture = map['userProfile'];
        
   Map<String, dynamic> toJson(){
    return {
       "postComments" : postComments,
       "postCreated" : postCreated,
       "postDetails" : postDetails,
       'postId' : postId,
       "postLikes" : postLikes,
       "postPicture" : postPicture,
       "postTitle" : postTitle,
       "userId" : userId,
       "userName" : userName,
       "userProfile" : userProfilePicture
    };
  }   
}