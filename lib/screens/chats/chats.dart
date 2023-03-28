import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/chats/widgets/chat_screen.dart';
import 'package:red_flag/screens/chats/widgets/no_chat.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/search_form.dart';
import 'package:sizer/sizer.dart';

class Chat extends StatefulWidget {
  const Chat({ Key? key }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat>with AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: kPrimaryColor,
       appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        title: CustomText(text: "Chat",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
         actions: [
             GestureDetector(
                onTap: () => Navigator.pushNamed(context, Notifications.routeName),
                child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,)),
              const SizedBox(width:10 ,),
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
              const SizedBox(width: 10,)
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kPadding,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const NoChat(),
              const SizedBox(height: 10,),
              
              StreamBuilder(
                stream:FirebaseFirestore.instance.collection('messages')
                .orderBy('lastMessage.timestamp', descending: true)
                .where('users', arrayContains: UserData.getUserId())
                .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                // if(snapshot.)
              if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error.toString()}"));
               } else {               
                      if(snapshot.data!.docs.isEmpty){
                        return const NoChat();
                      }
                        return Column(
                          children: [
                          // Search(name:"Search",
                          // controller: searchController,
                          // onChanged: (value){
                          //     // setState(() {
                                
                          //     // });
                          //   },),
                            const SizedBox(height: 20,),
                            ListView.separated(
                            shrinkWrap: true,
                            physics:const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {                    
                                final data = snapshot.data!.docs[index];
                                var parsedDate = HelperFunctions.getTime(data["lastMessage"]["timestamp"]);
                                String convertedDate = DateFormat("yyyy-MM-dd HH:MM").format(parsedDate);
                                final dateTime = DateTime.parse(convertedDate);
                                DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(data["lastMessage"]["timestamp"]));
                                DateTime now = DateTime.now();
                                // final currentT = DateTime.parse(convertedDate );
                               
                               return ListTile(
                                contentPadding: EdgeInsets.zero,
                              onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (ctx) =>  ChatScreen(
                               convoId: data.id,
                               peerId:data["senderDetails"]["userId"],
                               fullName:data["users"][0] == UserData.getUserId() ? data["postOwnerDetails"]["fullName"] :data["senderDetails"]["fullName"],
                               profilePicture: data["users"][0] == UserData.getUserId() ? data["postOwnerDetails"]["profileImage"] :data["senderDetails"]["profileImage"],
                               postOnnwerId: data["postOwnerDetails"]["userId"] ,
                            )));} ,
                               leading: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue,
                                image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(data["users"][0] == UserData.getUserId() ? data["postOwnerDetails"]["profileImage"] :data["senderDetails"]["profileImage"]),
                                ),
                              ),),
                               title: CustomText(text: data["users"][0] == UserData.getUserId() ? data["postOwnerDetails"]["fullName"] : data["senderDetails"]["fullName"], size: 12.sp,weight:FontWeight.w600),
                               subtitle:CustomText(text: data["lastMessage"]["content"],size: 13.sp,weight:FontWeight.w400),
                               trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                CustomText(text:time.day == now.day ? HelperFunctions.getFormattedTime(context: context, time: data["lastMessage"]["timestamp"]) : DateTimeFormat.format(dateTime,format: 'M j, H:i') ,size: 12.sp,weight:FontWeight.w600),
                                // const SizedBox(height:5),
                                // data["postOwnerDetails"]["userId"] == UserData.getUserId() ? CircleAvatar(
                                //   radius: 13,
                                //   backgroundColor: data["postOwnerDetails"]["unreadBadge"] == 0 ? Colors.transparent : Colors.red,
                                //   child: CustomText(text:data["postOwnerDetails"]["unreadBadge"] == 0 ? '' : data["postOwnerDetails"]["unreadBadge"].toString()  ,size: 12.sp,weight:FontWeight.w600,color:Colors.white))
                                //   : CircleAvatar(
                                //   radius: 13,
                                //   backgroundColor:data["senderDetails"]["unreadBadge"] == 0 ? Colors.transparent : Colors.red,
                                //   child: CustomText(text:data["senderDetails"]["unreadBadge"] == 0 ? '' : data["senderDetails"]["unreadBadge"].toString() ,size: 12.sp,weight:FontWeight.w600,color:Colors.white))
                               ],),
                                );
                            },
                          separatorBuilder: (context, index) => const Divider(), itemCount:snapshot.data!.docs.length),
                          ],
                        );}
                       
              //   }
              }
               )           
            ],
          ),
        ),
      ),
      
    );
  }
  @override
  bool get wantKeepAlive => true;
}