import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/chats/widgets/chat_screen.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/post_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class PostSearch extends StatefulWidget {
  const PostSearch({ Key? key,this.searchQuery}) : super(key: key);
  final String? searchQuery;
  @override
  State<PostSearch> createState() => _PostSearchState();
}

class _PostSearchState extends State<PostSearch> {
    @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PostViewModel>().searchPost(widget.searchQuery?.toLowerCase() ?? "", context));
  }

  @override
  void didChangeDependencies() {
        Future.microtask(() => context.read<PostViewModel>().searchPost(widget.searchQuery?.toLowerCase() ?? "", context));

    // context.read<PostViewModel>().onSearchTextChanged(widget.searchQuery ?? "");                   
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<PostViewModel>(
            builder: (context, provider, child) {
                if (provider.isLoading) {
                  return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
                }
                 if(widget.searchQuery == null || widget.searchQuery!.isEmpty){
                  return Center(child: CustomText(text: "Search Post"),);
                 } else {
                  return ListView.builder(
                  itemCount:provider.searchList.length,
                  itemBuilder:(context, index) { 
                    print(provider.searchList.length.toString());
                  final post = provider.searchList[index]; 

                  // if (post.details
                  // .toString()
                  // .toLowerCase()
                  // .contains(widget.searchQuery!.toLowerCase())) {
                  return Padding(
                  padding:const EdgeInsets.fromLTRB(15, 7, 15, 7),
                  child: Card(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19.0),
                  ),
                  elevation: 4,
                  child: Column(
                    children: [      
                  const SizedBox(height: 5,) ,    
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      const SizedBox(width: 10,),
                        Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue,
                          image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(post.userProfile ?? ""),
                          ),
                        ), ),
                                const SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  CustomText(text:post.userName == UserData.fullName() ? "You" : post.userName,size:13.sp,weight:FontWeight.w700),
                                  // CustomText(text: "5 mins ago",size:12.sp)
                                ],),
                                const Spacer(),
                                GestureDetector(
                                child: Image.asset("assets/icons/iwwa_option.png",width: 35,),
                              ) ],),
                                  Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child:post.postPicture == null ? CustomText(text: post.details) :
                                      Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
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
                                          imageUrl: post.postPicture ?? "" ),
                                        ),
                                          const SizedBox(height: 10,),
                                        CustomText(text: post.details,maxLines: 2,color:const Color(0xff657786),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:20.0,bottom: 15,top:7),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => provider.handleLikes(
                                            totalLikes: provider.postList[index].postLikes,
                                            postId: provider.postList[index].postId
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/icons/Heart.png",width:25, color: provider.postList[index].postLikes!.contains(UserData.getUserId()) ? Colors.red : Colors.black ,),
                                              const SizedBox(width: 5,),
                                              CustomText(text: post.postLikes?.length.toString(),size: 13.sp,)
                                            ],
                                          ),
                                        ),
                                        const  SizedBox(width: 15,),
                                        Image.asset("assets/icons/comment.png",width:25),
                                        const SizedBox(width: 15,),
                                          Visibility(
                                          visible: post.userId == UserData.getUserId() ? false : true,
                                            child: GestureDetector(
                                            onTap: () {
                                              final convoId = HelperFunctions.getConvoID(UserData.getUserId() ?? "", post.userId ?? "");
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(
                                              fullName:post.userName,
                                              peerId: post.userId,
                                              convoId: convoId,
                                              profilePicture: post.userProfile,
                                            )));
                                            },
                                            child: Image.asset("assets/icons/share.png",width:25)),
                                          ),
                                      ],
                                    ),
                                  )
                                  ],
                                ),
                                ),
                            
                          );
                        // } else {
                        // return Center(child: const CustomText(text: "n"));
                        // }
                        });
              
  }});
                     
               
  }
 
}