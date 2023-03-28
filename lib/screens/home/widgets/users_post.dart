import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/chats/widgets/chat_screen.dart';
import 'package:red_flag/screens/post_details/post_details.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/post_view_model.dart';
import 'package:red_flag/widgets/comment_post.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class UsersPost extends StatefulWidget {
  const UsersPost({ Key? key }) : super(key: key);

  @override
  State<UsersPost> createState() => _UsersPostState();
}

class _UsersPostState extends State<UsersPost> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PostViewModel>().getPost());
  }
  @override
  Widget build(BuildContext context) {   
    final size = MediaQuery.of(context).size;        
                    // final provider = Provider.of<PostViewModel>(context);
                return Consumer<PostViewModel>(
                  builder: (context, provider, child) {
                  if (provider.isLoading) {
                  return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
                } 
                return ListView.builder(
                  itemCount: provider.postList.length,
                  itemBuilder:(context, index) { 
                    final post = provider.postList[index]; 
                    var parsedDate = HelperFunctions.getTime(post.timeStamp ?? "");
                    String convertedDate = DateFormat("yyyy-MM-dd HH:MM").format(parsedDate);
                    final dateTime = DateTime.parse(convertedDate);                    //  final dateTime = HelperFunctions.converDate(post.timeStamp);               
                    return  Padding(
                      padding:const EdgeInsets.fromLTRB(14, 5, 18, 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19.0),
                      ),
                      elevation: 1,
                      child: Column(
                        children: [      
                      SizedBox(height: 2.2.h,) ,    
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      const SizedBox(width: 10,),
                      Container(
                      height: size.height / 19,
                      width: size.width / 9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                        image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(post.userProfile ?? ""),
                        ),
                      ),
              ),
              const SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                CustomText(text:post.userName == UserData.fullName() ? "You" : post.userName,size: size.width / 23,weight:FontWeight.w700),
                CustomText(text:DateTimeFormat.format(dateTime,format: 'D, M j'),size:size.width / 26)
              ],),
            //   const Spacer(),
            //   GestureDetector(
            //   child: Image.asset("assets/icons/iwwa_option.png",width:7.w,),
            // ),
           //const SizedBox(width: 4,)
          ],),

          GestureDetector(
            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> PostDetails(postModel: post))),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child:post.postPicture == null ? 
              CustomText(text: post.details,maxLines: 7,overflow: TextOverflow.ellipsis,color:const Color(0xff657786),weight: FontWeight.w400,) : 
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        SizedBox(
                          height:27.h,
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
                       SizedBox(height: size.height / 43,),
                        CustomText(text: post.details,maxLines: 2,color:const Color(0xff657786),)
                      ],),
                  ),
             ),     
              Padding(
                padding: EdgeInsets.only(left:20.0,bottom: 15,top:post.postPicture == null ? 7 : 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => provider.handleLikes(
                        totalLikes: provider.postList[index].postLikes,
                        postId: provider.postList[index].postId
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/ant-design_heart-filled.png",width:size.width / 18,color: provider.postList[index].postLikes!.contains(UserData.getUserId()) ? Colors.red : Colors.grey,)
                          ,
                          const SizedBox(width: 5,),
                          CustomText(text: post.postLikes?.length.toString(),size: 13.sp,color:const Color(0xff657786),weight: FontWeight.w400,)
                        ],
                      ),
                    ),
                          const  SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CommentPost(
                              postId: post.postId,
                              postOwnerId: post.userId,
                            ))),
                            child: Image.asset("assets/icons/comment.png",width:size.width / 21)),
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
                              child: Image.asset("assets/icons/share.png",width:size.width / 21)),
                            ),
                            ],
                          ),
                        )
                        ],
                      ),                 
                ));});
                  }
                );
            }
}