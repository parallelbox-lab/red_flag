import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/post_model.dart';
import 'package:red_flag/screens/chats/widgets/chat_screen.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/post_view_model.dart';
import 'package:red_flag/widgets/comment_post.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({ Key? key, required this.postModel }) : super(key: key);
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<PostViewModel>(context);
   final size  = MediaQuery.of(context).size;
     return Scaffold(
       appBar:AppBar(
        automaticallyImplyLeading: true,
        iconTheme:const IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        title: CustomText(text: "Post",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
       actions: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Notifications.routeName),
                child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,)),
              const SizedBox(width: 20,),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Profile.routeName),
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                      image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(UserData.getUserProfilePic() ?? ""),
                      ),
                    ),
                    )),
              ),
              const SizedBox(width: 20,)
              ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Expanded(child: ),
            Visibility(
              visible:postModel.postPicture == null ? false : true ,
              child:  SizedBox(
                                              height:30.h,
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) => const Center(
                                                  child: Text(
                                                      "Unable to load image")), // This is what you need
                                              progressIndicatorBuilder:
                                                  (context, url, progress) => Center(
                                                child: CircularProgressIndicator(
                                                  value: progress.progress,
                                                ),
                                              ),
                                              imageUrl: postModel.postPicture ?? "" ),
                                            ),),
            const SizedBox(height: 20),
            CustomText(text:postModel.details),
              const SizedBox(height: 10),
             Row(
                  children: [
                    GestureDetector(
                      onTap: () => provider.handleLikes(
                        totalLikes: postModel.postLikes,
                        postId: postModel.postId
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/ant-design_heart-filled.png",width:size.width / 18,color: postModel.postLikes!.contains(UserData.getUserId()) ? Colors.red : Colors.grey,)
                          ,
                          const SizedBox(width: 5,),
                          CustomText(text: postModel.postLikes?.length.toString(),size: 13.sp,color:const Color(0xff657786),weight: FontWeight.w400,)
                        ],
                      ),
                    ),
                          const  SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CommentPost(
                              postId: postModel.postId,
                              postOwnerId: postModel.userId,
                            ))),
                            child: Image.asset("assets/icons/comment.png",width:size.width / 21)),
                          const SizedBox(width: 15,),
                            Visibility(
                            visible: postModel.userId == UserData.getUserId() ? false : true,
                              child: GestureDetector(
                              onTap: () {
                                final convoId = HelperFunctions.getConvoID(UserData.getUserId() ?? "", postModel.userId ?? "");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(
                                fullName:postModel.userName,
                                peerId: postModel.userId,
                                convoId: convoId,
                                profilePicture: postModel.userProfile,
                              )));
                              },
                              child: Image.asset("assets/icons/share.png",width:size.width / 21)),
                            ),
                            ],
                     ),     
         const  SizedBox(height: 20,),
        const CustomText(text: "Comments...", weight: FontWeight.w800,),
              const  SizedBox(height: 20,),
              StreamBuilder(
                stream: FirebaseFirestore.instance.
            collection("PostsCollection").
           doc(postModel.postId).collection("CommentsCollection")
            .orderBy('addedTime', descending: true)
            .limit(20)
            .snapshots(),
                builder: (context,  AsyncSnapshot<QuerySnapshot>snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
                } else {
                  if(snapshot.data!.docs.isEmpty){
                   return const CustomText(text: "No Comment Yet");
                  }
                  return ListView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index){
                      final data = snapshot.data?.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue,
                                  image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(data?["userProfileImage"]),
                                  ),
                                ),
                        ), 
                         const SizedBox(width: 10,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             CustomText(text: data?["commentBy"],size:13.sp,weight: FontWeight.w700,),
                             const SizedBox(height: 10,),
                             CustomText(text: data?["details"],size:11.sp),
                           ],
                         ),
                         const Spacer(),
                        // CustomText(text: "3 Days Ago",size:11.sp),
                        ],),
                      );
                    });
                }}
              ),                              
          ]),
        ),
      )
    );
  }
}