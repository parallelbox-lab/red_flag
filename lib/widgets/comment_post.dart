import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/view_model/post_view_model.dart';
import 'package:red_flag/widgets/common.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
class CommentPost extends StatefulWidget {
  const CommentPost({ Key? key,this.postId,this.postOwnerId }) : super(key: key);
  final String? postId;
  final String? postOwnerId;
  @override
  State<CommentPost> createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {
  TextEditingController commentTex = TextEditingController();
  Future sendComment() async {
     bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    if (isConnected == true) {
    if(commentTex.text.isNotEmpty){
      FocusScope.of(context).unfocus();
      context.read<PostViewModel>().commentPost(
        postId: widget.postId,
        postOwnerId: widget.postOwnerId,
        comment: commentTex.text.trim(),
      );
      commentTex.clear();
    }
     } else {
      showerrorDialog("No network connection 😞", context,false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Comments",size:15.sp,weight: FontWeight.w800,),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child:
              StreamBuilder(
                stream: FirebaseFirestore.instance.
            collection("PostsCollection").
           doc(widget.postId).collection("CommentsCollection")
            .orderBy('addedTime', descending: true)
            .limit(20)
            .snapshots(),
                builder: (context,  AsyncSnapshot<QuerySnapshot>snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
                } else {
                   if(snapshot.data!.docs.isEmpty){
                   return const  Center(child: CustomText(text: "No Comment Yet"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index){
                      final data = snapshot.data?.docs[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8,15,8,15),
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
                         CustomText(text: "3 Days Ago",size:11.sp),
                        ],),
                      );
                    });
                }}
              ) ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Container(          
            decoration:const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(30)),
             ),
                alignment: Alignment.bottomCenter,
                  // color: Colors.white.withOpacity(0.9),
                  padding:
                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                        controller:commentTex,
                        // onChanged: (value) {
                        //   state(() => value = _chatController.text);
                        // },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Write a comment",
                          hintStyle:
                              TextStyle(color: Colors.black,fontSize: 12.sp),
                          border: InputBorder.none,
                        
                        ),
                      )),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: ()=>                       
                          sendComment()                        
                        ,
                        child: Image.asset("assets/icons/send.png",width:43)),
                      const SizedBox(width:10)
                    ],
                  ),
                ),
          )    
          ],),
        ),

    );
  }
}