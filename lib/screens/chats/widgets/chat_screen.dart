import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/chats/widgets/chat_bubble.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/chat_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatScreen extends StatefulWidget {
  final String? profilePicture;
  final String? fullName;
  final String? peerId;
  final String? convoId;
  final String? postOnnwerId;

  const ChatScreen({ Key? key,this.profilePicture, this.fullName, this.peerId, this.convoId, this.postOnnwerId}) : super(key: key);
 static String routeName = "/chat-screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? uid, convoID, fullName, peerId, profilePicture;
  TextEditingController chatText = TextEditingController();
  @override
  void initState() {
   super.initState();
   uid = UserData.getUserId();
   convoID = widget.convoId;
   fullName = widget.fullName;
   peerId = widget.peerId;
   profilePicture = widget.profilePicture;
  initializeDateFormatting();
  }

  File? imageFile;
  final _picker = ImagePicker();
  int unReadBadge = 0;
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
       imageFile = File(pickedFile.path);
      });
    //  Navigator.push(context, MaterialPageRoute(builder: (ctx) => ImagePreview(imagePreview: imageFile,)));
    }
  }
  
  void onSendMessage(String content) {
    if (content.trim() != '') {
       FocusScope.of(context).unfocus();
      chatText.clear();
      content = content.trim();
      unReadBadge = unReadBadge + 1;
      print(unReadBadge.toString());
      Provider.of<ChatViewModel>(context, listen: false).sendMessage(
        convoID ?? "",
        uid ?? "", 
        peerId ?? "",
        content,
        fullName ?? "",
        profilePicture ?? "",
        DateTime.now().millisecondsSinceEpoch.toString(),
        "",
        unReadBadge
      );
      // listScrollController.animateTo(0.0,
      //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ChatViewModel>(context);
    return Scaffold(
        backgroundColor: kPrimaryColor,
       appBar:AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        automaticallyImplyLeading: false,
        // leading: ,
        // leadingWidth: 40,
        titleSpacing: 5,
        title: Row(
          children: [
          const SizedBox(width: 5,),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child:Image.asset("assets/icons/close.png",width:44) ),
            const SizedBox(width: 5,),
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Profile.routeName),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                      image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(profilePicture ?? ""),
                      ),
                    ),
                    )),
              ),            const SizedBox(width: 7,),
            CustomText(text: widget.fullName ?? "",color: Colors.black,size:size.width / 25,weight: FontWeight.w500,),
          ],
        ),
        actions: [
        const SizedBox(width: 20,),
        Image.asset("assets/icons/info.png",width: 28,),
        SizedBox(width: size.width / 30 ,),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(convoID)
            .collection(convoID ?? "")
            .orderBy('timestamp')
            .limit(20)
            .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                if(snapshot.hasData){
                // final listMessage = snapshot.data?.docs;                
                return snapshot.data!.docs.isEmpty ?
                 const Center(child: CustomText(text: "Say Hi .."))
                 :  StickyGroupedListView(
                  floatingHeader: true,
                  reverse: true,
                  elements: snapshot.data!.docs,
                  groupBy: (QueryDocumentSnapshot<Object?>? document) => DateFormat('dd. MMMM, EEEE').format(DateTime.fromMillisecondsSinceEpoch(int.parse(
                      document?.get('timestamp')))),
                 order: StickyGroupedListOrder.DESC, // optional
                  //itemScrollController: GroupedItemScrollController(), // optional
                  groupSeparatorBuilder:(QueryDocumentSnapshot<Object?>? document)  {
                   var parsedDate = HelperFunctions.getTime(document?.get('timestamp'));
                    String convertedDate = DateFormat("yyyy-MM-dd HH:MM").format(parsedDate);
                    final dateTime = DateTime.parse(convertedDate);
                    DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(document?.get('timestamp')));
                    DateTime now = DateTime.now();
                    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
                   return Container(
                    height: size.height / 40,
                    margin: EdgeInsets.only(left: size.width * 0.37,right:size.width * 0.37),
                    decoration: BoxDecoration(
                      color: const Color(0xff3F37C9),
                      borderRadius: BorderRadius.circular(20)

                    ),
                    child: Center(child: CustomText(text:time.day == now.day ? "Today" : time.day == yesterday.day? "Yesterday" : DateTimeFormat.format(dateTime,format: 'D, j M'),textAlign: TextAlign.center,size: 10.sp,color: Colors.white,)));
                  },
                  itemBuilder: (context, QueryDocumentSnapshot<Object?>? document) {
                  final messages = document;               
                    // if (messages!["read"] == false && messages['idTo'] == peerId) {
                    //   unReadBadge = 0;
                    //   provider.updateMessageRead(messages, convoID ?? "",peerId ?? "");
                    // }
                     return ChatBubble(
                      text: messages?['content'],
                      username: fullName ?? "",
                      userId: UserData.getUserId(),
                      currentUserId: messages?['idFrom'],
                      imageUrl: '',
                      isRead: messages?['read'] ,
                      time:messages?['timestamp'] ,
                      profilePicture:profilePicture,);
                  }
                  );
              } else {
            return Center(child:Platform.isAndroid ? const CircularProgressIndicator() : const CupertinoActivityIndicator());
          }
           }
         ),
        ),
        Container(
          decoration:const BoxDecoration(
            border:Border(
            top: BorderSide(color: Color(0xff14171A)),
            )
           ),
              alignment: Alignment.bottomCenter,
                // color: Colors.white.withOpacity(0.9),
                padding:
                    const EdgeInsets.fromLTRB(8, 15, 8, 20),
                child: Row(
                  children: [
                //  GestureDetector(
                //  // onTap: () => ,
                //   child: Image.asset("assets/icons/image.png",width: 40,)),
                  const SizedBox(width:15),
                    Expanded(
                      child: TextField(
                      controller:chatText,
                      // onChanged: (value) {
                      //   state(() => value = _chatController.text);
                      // },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Start a Message",
                        hintStyle:
                            TextStyle(color: Colors.black,fontSize: 12.sp),
                        border: InputBorder.none,
                      
                      ),
                    )),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: ()=> onSendMessage(chatText.text),
                      child: Image.asset("assets/icons/send.png",width:43)),
                    const SizedBox(width:10)
                  ],
                ),
              )
        ],
      ),
      
    );
  }
}