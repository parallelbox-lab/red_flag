class AffirmationModel{
  String? postId;
  String? post;
  String? title;
  String? postPicture;
  String? affirmationvideo;
  String? postCreated;

  AffirmationModel ({
  this.postId,
  this.post,
  this.title,
  this.postPicture,
  this.affirmationvideo,
  this.postCreated
  });

 AffirmationModel.fromJson(Map<String,dynamic> map,)
 : postId = map['postId'],
   post = map['post'],
   postPicture = map['postPicture'],
   affirmationvideo = map["affirmationvideo"],
   title = map['title'],
   postCreated = map['postCreated'];
   
    Map<String, dynamic> toJson(){
    return{
     'postId' : postId,
     'post' : post,
     'postPicture' : postPicture,
     'affirmationvideo' : affirmationvideo,
     'title' : title,
     'postCreated': postCreated
    };
  }


}