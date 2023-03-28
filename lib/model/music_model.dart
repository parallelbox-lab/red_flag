class MusicModel{
  String? id;
  String? post;
  String? title;
  String? postPicture;
  String? postCreated;

  MusicModel({
  this.id,
  this.post,
  this.title,
  this.postPicture,
  this.postCreated
  });

  MusicModel.fromJson(Map<String,dynamic> map,)
 : id = map['postId'],
   post = map['post'],
   title = map['title'],
   postPicture = map['postPicture'],
   postCreated = map['postCreated'];
 
     Map<String, dynamic> toJson(){
    return{
     'postId' : id,
     'post' : post,
     'title' : title,
     'postPicture' : postPicture,
     'postCreated' : postCreated
    };
  }

}