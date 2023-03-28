import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_flag/data/repository/admin_post_repository.dart';
import 'package:red_flag/data/services/upload_image.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/affirmation_model.dart';
import 'package:red_flag/model/our_stories_model.dart';
import 'package:red_flag/widgets/common.dart';

class AdminPost extends ChangeNotifier{
  AdminPostRepositoryImpl adminPostRepositoryImpl = AdminPostRepositoryImpl();
  TextEditingController titleTex = TextEditingController();
  TextEditingController postDetailsTex = TextEditingController(); 
  TextEditingController  i = TextEditingController();  
  //  bool _imageLink = false;
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  File? videoFile;
  final _picker = ImagePicker();
   void loading(bool loading){
   _isLoading = loading;
   notifyListeners();
  }

  Future getVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery,
        );
    if (pickedFile != null) {
        // _imageLink = true;
        videoFile = File(pickedFile.path);
    }
  }

  Future<void> createAffirmation(BuildContext context, {File? imageFile}) async {
    String? vidoeUrl;
    String? imageUrl;
    if(imageFile != null && videoFile != null){
     vidoeUrl = await UploadImage.uploadVideo(video: videoFile);
     imageUrl = await UploadImage.uploadImage(image: imageFile);
    }
    videoFile = null;
    imageFile = null;
    AffirmationModel affirmationModel = AffirmationModel(
     post: postDetailsTex.text.trim(),
     title: titleTex.text.trim(),
     postPicture: imageUrl,
     affirmationvideo: vidoeUrl,
     postCreated: DateTime.now().microsecondsSinceEpoch.toString());
    try{
    loading(true);
    postDetailsTex.clear();
    vidoeUrl = null;
    imageUrl = null;
    titleTex.clear();
    notifyListeners();
    adminPostRepositoryImpl.createAffirmation(affirmationModel: affirmationModel);
    loading(false);
    showAlertDialog(context,message: "Affirmation Video Created Successfully", press: (){
       Navigator.pop(context);
       Navigator.pop(context);
    });
      loading(false);
    } catch(e){
     loading(false);
     showerrorDialog(e.toString(), context, false);
    }

  }
  
  Future<void> createPost(BuildContext context,{File? imageFile}) async {
   OurStoriesModel ourStoriesModel = OurStoriesModel(
    postComments: 0,
    postCreated:  DateTime.now().millisecondsSinceEpoch,
    postDetails: postDetailsTex.text.trim(),
    postTitle: titleTex.text.trim(),
    userId: UserData.getUserId(),
    userName: UserData.fullName(),
    userProfilePicture: "",
    postLikes: [],
   );
   try{
    postDetailsTex.clear();
    titleTex.clear();
    imageFile == null;
    notifyListeners();
    adminPostRepositoryImpl.createStory(ourStoriesModel:ourStoriesModel);
    showAlertDialog(context,message: "Post Created Successfully", press: ()=> Navigator.pop(context));
   } catch(e) {
    showerrorDialog(e.toString(), context, false);
   }
  }

  
}