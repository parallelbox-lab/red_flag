
class SharePostModel{
  String? id;
  String? postText;
  String? imageUrl;
  String? videoUrl;
  String? userId;
  String? fullname;

  SharePostModel({
    this.id,
    this.imageUrl,
    this.postText,
    this.fullname,
    this.userId,
    this.videoUrl
  });


  SharePostModel.fromJson(Map<String, dynamic> map,)
   : id = map['id'],
     imageUrl = map['imageUrl'],
     videoUrl = map['videoUrl'],
     fullname = map['fullName'],
     userId = map['userId'],
     postText = map['postText'];

     Map<String, dynamic> toJson(){
    return {
      'id' : id,
     'imageUrl' : imageUrl,
     'fullName' : fullname,
     'userId' : userId,
     'videoUrl' : videoUrl,
     'postText' : postText,
    };
 }
}