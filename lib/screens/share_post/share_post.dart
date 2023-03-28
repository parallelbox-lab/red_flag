import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/upload_image.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/post_model.dart';
import 'package:red_flag/view_model/share_post_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/image_preview.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class SharePost extends StatefulWidget {
  const SharePost({ Key? key }) : super(key: key);

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> with AutomaticKeepAliveClientMixin {
final ScrollController _controller = ScrollController();
bool isEdited = false;
File? imageFile;
final _picker = ImagePicker();
/// Get image from gallery
 Future getFromGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 60);
    if (pickedFile != null) {
      setState(() {
        // imageCheck = true;
       isEdited = true;
       imageFile = File(pickedFile.path);
      });
    //  Navigator.push(context, MaterialPageRoute(builder: (ctx) => ImagePreview(imagePreview: imageFile,)));
    }
  }
  Future getFromCamera(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 60);
    if (pickedFile != null) {
      setState(() {
        // imageCheck = true;
       isEdited = true;
       imageFile = File(pickedFile.path);
      });
     // Navigator.push(context, MaterialPageRoute(builder: (ctx) => ImagePreview(imagePreview: imageFile,)));
    }
  }


  final TextEditingController postText = TextEditingController();
  bool isLoading = false;
  Future createPost() async {
  FocusScope.of(context).unfocus();
    // SharePostModel sharePostModel = SharePostModel(
    //   postText: postText.text.trim(),
    //   fullname: Auth.fullName(),
    // );
    String? imageUrl;
    if(imageFile != null){
     imageUrl = await UploadImage.uploadImage(image: imageFile);
    }
   imageFile = null;
    PostModel postModel = PostModel(
      details:postText.text.trim(),
      userId: UserData.getUserId(),
      // postId: FirebaseFirestore.instance.collection('PostsCollection').doc().id,
      userName: UserData.fullName(),
      postLikes: [],
      postComments: 0,
      userProfile: UserData.getUserProfilePic(),
      postPicture: imageUrl,
      timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
      userAvatarMode: false
    );
    Provider.of<SharePostViewModel>(context,listen: false).createPost(context,sharePostModel: postModel);
    postText.clear();
    setState(()=> isLoading = false);

  }
  @override
  Widget build(BuildContext context) {
    super.build(context); // ScreenUtil.init();
    final size = MediaQuery.of(context).size;
    return Scaffold(
     resizeToAvoidBottomInset: false, // this is new
      backgroundColor: kPrimaryColor,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          CustomText(text: "Share Post",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
          // postText.text.isEmpty || imageGetter.imageFile == null  ? null : 
            GestureDetector(
              onTap:isEdited == false ? 
              null
               : (){
                setState(() => isLoading = true);
                createPost();
                // provider.createPost()
              },
              child:isLoading ? Row(children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 6,),
                CustomText(text:"Post",size:17.sp,weight:FontWeight.w700,color:Colors.grey)
              ],) : CustomText(text:"Post",size:17.sp,weight:FontWeight.w700,color:isEdited == false  ?  Colors.grey : const Color(0xff3F37C9)))
          ],
        ),      
      ),
     body: Padding(
         padding: kPadding,
         child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
             children: [          
             Expanded(
               child: ListView(
                controller: _controller,
                 children: [
                Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                  children: [
                   Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                    image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(UserData.getUserProfilePic() ?? ""),
                    ),
                  ),
                  ),
                   const SizedBox(width:10),
                   Expanded(child: CustomText(text: UserData.getUserEmail(),size:14.sp)),
                  ],
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: postText,
                  onChanged: (value){
                    value = postText.text;
                    if(value.isNotEmpty){
                      setState(()=> isEdited = true);
                    }else {
                      setState(()=> isEdited = false);
                    }
                  },
                  // textAlign: TextAlign.center,
                  minLines: 1,
                  maxLines:15,
                  keyboardType: TextInputType.multiline,
                  decoration:const InputDecoration(
                  hintText: "What do you want to talk about?",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 18),
                      ),
                    ), 
                  const SizedBox(height: 10,),
                   imageFile == null ? const Text('') : Stack(
                   children: [
                   Image.file(imageFile!,
                  fit: BoxFit.cover,),
                  Positioned(
                    top:-5,
                    right:1,
                    child: IconButton(onPressed: ()=> setState((){ 
                      imageFile = null;
                      isEdited = false;
                    }), icon:Icon(Icons.cancel,size: 21.sp,color: Colors.white,)))
                  ],)                 
                  // Image.asset("assets/images/image.png"),                    
                 ],
               ),
             ),
            //  const Expanded(child: SizedBox()),
           const SizedBox(height: 10,),
               Row(
                    children: [
                      GestureDetector(
                        onTap: ()=>
                          getFromCamera(context),
                        child: Image.asset("assets/icons/ant-design_camera-filled.png",width:size.width / 12,color: Colors.red,)),
                      const SizedBox(width:10),
                      GestureDetector(
                        onTap: ()=>
                        getFromGallery(context),
                        child: Image.asset("assets/icons/bi_card-image (1).png",width: size.width / 14,color:const Color(0xff3F37C9))),
                      // const SizedBox(width:10),
                      // GestureDetector(child: Image.asset("assets/icons/bi_camera-video-fill.png",width: 30,)),
                      // const SizedBox(width:20),
                      // Image.asset("assets/icons/Group 764.png",width: 30,),
                ],),   
                const SizedBox(height: 10,),        
                // CustomText(text: "Image Upload is required",color: Colors.red,size:11.sp)           
            ],
           ),
       ), 
    );
  }
  @override
  bool get wantKeepAlive => true;
}