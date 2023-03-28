import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/chats/widgets/chat_screen.dart';
import 'package:red_flag/screens/payments_subscription/payment_sub.dart';
import 'package:red_flag/screens/post_details/post_details.dart';
import 'package:red_flag/screens/profile/wigets/add_story.dart';
import 'package:red_flag/screens/profile/wigets/edit_profile.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/post_view_model.dart';
import 'package:red_flag/view_model/register_view_model.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/comment_post.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);
static String routeName = "/profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PostViewModel>().getPostByUsers());
  }
  @override
  Widget build(BuildContext context) {
  bool? drawerCanOpen = true;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:const Color(0xffF5F8FA),
      key: scaffoldkey,
      drawer: navBar(context),
      body: SafeArea(
        child: Padding(
            padding: kPadding,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset("assets/icons/back_button.png",width: 35,),
                ),
                GestureDetector(
                  onTap: () {
                  if (drawerCanOpen) {
                    scaffoldkey.currentState?.openDrawer();
                  }
               },
                  child: Image.asset("assets/icons/cil_settings.png",width:35,),
                )
              ],),
              const SizedBox(height:5),
              // CircleAvatar(
              //   radius: 100,
              //   child: 
        Stack(
          children: [
            Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.blue,
                      image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(UserData.getUserProfilePic() ?? ""),
                      ),
            ),),   
        // Positioned(
        //       right:0,
        //       bottom:40,
        //       child: CircleAvatar(
        //         backgroundColor: Colors.white,
        //         radius: 25,
        //         child: Image.asset("assets/icons/bi_camera-fill.png",width: 30,),))
          ],
        ),
      const  SizedBox(height: 10,),
      CustomText(text: UserData.fullName(),size:19.sp,weight:FontWeight.w600),
      const  SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.only(left:8,right:8),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
                margin: const EdgeInsets.only(bottom: 5.0),
            decoration: BoxDecoration(
                  // border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(7.0),
                  color: Colors.white,
                  ),
                height: size.height / 19,
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      primary: Colors.white,
                      backgroundColor:const Color(0xff3F37C9),
                    ),
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const AddStory())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Image.asset("assets/icons/akar-icons_circle-plus-fill.png",width:25),
                      const SizedBox(width: 5,),
                        Text("Add to Story",
                            style:GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontFamily: 'Core Pro',
                                fontSize: size.width / 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                            textAlign: TextAlign.center),
                      ],
                    ))),
        ),
        SizedBox(width: size.width / 25 ,),
        Expanded(
          child: Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                height: size.height / 19,
                decoration: BoxDecoration(
                  // border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12.0),
                  color:const Color(0xffE1E8ED),
                  ),
                child: TextButton(
                    style: TextButton.styleFrom(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(7.0)),
                      primary: Colors.black,
                    ),
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const EditProfile())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Image.asset("assets/icons/jam_pen-f.png",width:25),
                      const SizedBox(width: 10,),
                        Text("Edit Profile",
                            style:GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontFamily: 'Core Pro',
                                fontSize: size.width / 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                            textAlign: TextAlign.center),
                      ],
                    ))),
        ),
      ],
    ),
              ),
    const SizedBox(height: 15,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      CustomText(text: "Posts",size: 16.sp,weight: FontWeight.w700,),
     // GestureDetector(child: Image.asset("assets/icons/iwwa_option.png",width:35))
    ],),
    const SizedBox(height: 10,),
     Row(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
         Container(
              height: size.height / 18,
              width: size.width * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
                image: DecorationImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(UserData.getUserProfilePic() ?? ""),
                ),
              ),) ,
              const SizedBox(width:20),
             CustomText(text: "What do you want to talk about?",size:12.sp),
            ],
          ),
      const Divider(thickness: 2,),
  //     const SizedBox(height: 5,),
  //  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //     Row(
  //       children: [
  //         Image.asset("assets/icons/ant-design_camera-filled.png",width:30,color:const Color(0xffF93E3D),),
  //         const SizedBox(width: 5,),
  //         CustomText(text: "Camera",size: 11.sp,)
  //       ],
  //     ),
      
  //     Row(
  //       children: [
  //         Image.asset("assets/icons/bi_camera-video-fill.png",width:30,color:const Color(0xff89BD4D),),
  //         const SizedBox(width: 5,),
  //         CustomText(text: "Photo",size: 11.sp,)
  //       ],
  //     )
  //   ],
  //  ),
   const SizedBox(height: 10,),
    Consumer<PostViewModel>(
      builder: (context,vm, child) {
        if(vm.isLoading){
          return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
        }
       if(vm.postByUsersList.isEmpty){
        return const CustomText(text: "No Post made by you yet");
        }
       return  Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
                  itemCount: vm.postByUsersList.length,
                  physics:const BouncingScrollPhysics(),
                    itemBuilder:(context, index) {  
                      final post =  vm.postByUsersList[index];               
                      return GestureDetector(
                        onTap:() => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> PostDetails(postModel: post))),
                        child: Padding(
                            padding:const EdgeInsets.all(2),
                            child: Card(
                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(19.0),
                                ),
                                          elevation: 2,
                                          child: Column(
                        children: [  
                         const SizedBox(height: 10,),         
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            ),),
                                        const SizedBox(width: 15,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          CustomText(text:post.userName == UserData.fullName() ? "You" : post.userName,size:13.sp,weight:FontWeight.w700),
                                          // CustomText(text: "5 mins ago",size:12.sp)
                                        ],),
                                      //  const Spacer(),
                                      //   GestureDetector(
                                      //   child: Image.asset("assets/icons/iwwa_option.png",width: 35,),
                                      // )
                                   ],),
                      
                                      Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child:post.postPicture == null ? CustomText(text: post.details,maxLines: 7,overflow: TextOverflow.ellipsis) :
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
                      onTap: () => vm.handleLikes(
                        totalLikes: vm.postList[index].postLikes,
                        postId: vm.postList[index].postId
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/ant-design_heart-filled.png",width:size.width / 18,color: vm.postList[index].postLikes!.contains(UserData.getUserId()) ? Colors.red : Colors.grey,)
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
                                   )
                          ),
                      );})
        );
      }
    ), 

           // )
            
          ],),
        ),
      ),
      
    );
  }

  SizedBox navBar(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);
    return SizedBox(
      width:290,
      child: Drawer(
      backgroundColor: kPrimaryColor,
      child: Column(
        // Important: Remove an
        //y padding from the ListView.
        // padding: EdgeInsets.zero,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            margin:  EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration:const  BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //  const  Padding(
              //     padding: EdgeInsets.only(left:10.0),
              //     child: BackButton(color:Colors.white),
              //   ),                
                  Padding(
                    padding: const EdgeInsets.only(left:20,top:10,bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue,
                            image: DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(UserData.getUserProfilePic() ?? ""),
                            ),
                          ),
                  ),  
                  const SizedBox(height: 10,),
                  CustomText(text: UserData.fullName(),size:14.sp,color:Colors.black,weight:FontWeight.w500),
                        // CustomText(text: "View Profile",color:Colors.white,decoration: TextDecoration.underline,size:12.sp)
                     ],
               ),
                  ),
             ],
            ),
          ),
          // ListTile(
          //   leading: Image.asset("assets/icons/Group.png",width: 25,
          //           height: 25,),
          //   minLeadingWidth: 2,
          //   title: CustomText(text: "Avatar mode",size: 12.sp,color:Colors.black,weight: FontWeight.w600,),
          //   onTap: () {
          //     // Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Dashboard()));
          //   },
          // ),
           ListTile(
            leading:Image.asset("assets/icons/bi_credit-card.png",width: 25,
                    height: 25,),
            minLeadingWidth: 2,
            title: CustomText(text: "Payments and Subscrition",size: 12.sp,color:Colors.black,weight: FontWeight.w600,),
            onTap: () {
               Navigator.pushNamed(context, PaymentSubscription.routeName);
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (ctx) => const AllCustomers()));
            },
          ),
        //  const SizedBox(height:15),
        //    ListTile(
        //     leading:Image.asset("assets/icons/akar-icons_block.png",width: 25,
        //             height: 25,),
        //    minLeadingWidth: 2,
        //     title: CustomText(text: "Block List",size: 12.sp,color:Colors.black,weight: FontWeight.w600,),
        //     onTap: () {
        //       // Navigator.push(context, MaterialPageRoute(builder: (ctx) => const AllOrders()));
        //     },
        //   ),
        //   ListTile(
        //     leading:Image.asset("assets/icons/cil_settings copy.png",width: 25,
        //             height: 25,),
        //    minLeadingWidth: 2,
        //     title: CustomText(text: "Settings",size: 12.sp,color:Colors.black,weight: FontWeight.w600,),
        //     onTap: () {
        //       // Navigator.push(context, MaterialPageRoute(builder: (ctx) => const AllOrders()));
        //     },
        //   ),
          const SizedBox(height:15),
           ListTile(
            leading:Image.asset("assets/icons/majesticons_door-exit-line.png",width: 25,
                    height: 25,),
           minLeadingWidth: 2,
            title: CustomText(text: "Logout",size: 12.sp,color:Colors.black,weight: FontWeight.w700,),

            onTap: ()=> vm.logout(context),
          ),
          const Spacer(),
            Padding(
              padding:  EdgeInsets.only(bottom:MediaQuery.of(context).size.height /40, left:MediaQuery.of(context).size.width/ 90),
              child: ListTile(
              leading:Icon(Icons.delete, color: Colors.red,size: 14.sp,),
           minLeadingWidth: 2,
              title: CustomText(text: "Delete Account",size: 12.sp,color:Colors.black,weight: FontWeight.w700,),
              onTap: ()=>  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                        CustomText(text:"Are you sure, you want to delete your account")],),
                        actions: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(child: ButtonWidget(text: "No",press: () => Navigator.pop(context),)),
                              const SizedBox(width:20),
                              Expanded(child: ButtonWidget(text:"Yes", press: () async { 
                                vm.deleteProfile(context);
                               // Navigator.pop(context);
                                }
                              ,)),
                              ],
                            ),
                          ),
                    
                  ],
              );
  })),
            ),
          // const SizedBox(height:15),
          //  ListTile(
          //   leading:Image.asset("assets/icons/Wallet.png",width: 25,
          //           height: 25,),
          //  minLeadingWidth: 2,
          //   title: CustomText(text: "Payment Status",size: 12.sp,color:Colors.white),
          //   onTap: () {
          //     Navigator.pushNamed(context, PaymentStatus.routeName);
          //   },
          // ),
           
        // SizedBox(height:10.h),
        //       ListTile(
        //     leading: Image.asset("assets/icons/cil_link.png",width: 25,
        //             height: 25,),
        //     minLeadingWidth: 2,
        //     title: CustomText(text: "Sign out",size: 12.sp,color:Colors.white),
        //     onTap: ()async {
        //      await vm.of<Authvm>(context, listen: false).logout();
        //      Navigator.pushNamedAndRemoveUntil(context, SignIn.routeName, (route) => false);
        //     },
        //   ),
        ],
      ),
  ),
    );
  }
}