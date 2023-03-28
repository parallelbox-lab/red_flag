// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
// import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, this.text, this.userId,this.currentUserId,this.username,this.imageUrl,this.profilePicture, this.time, this.isRead
  }) : super(key: key);
  final String? text;
  final  String? currentUserId;
  final String? username;
  final String? userId;
  final String? profilePicture;
  // final Timestamp? timeStamp;
  final String? imageUrl;
  final String? time;
  final bool? isRead;
  @override
  Widget build(BuildContext context) {
    // final dateTime =
    //     DateTime.fromMillisecondsSinceEpoch(timeStamp!.seconds * 1000);
    return Row(
      mainAxisAlignment:currentUserId! == userId ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16
          ),
          child: Row(
            children: [
              Visibility(
                    visible:currentUserId == userId ? false : true,
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
                    ),),),
              const  SizedBox(width: 10,),
              Container(
                width:160,
                padding:const EdgeInsets.all(5),
                // alignment:
                //     currentUserId == userId ? Alignment.centerRight : Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: currentUserId! == userId ? const Color(0xff3F37C9) :  Colors.grey[300],
                    borderRadius:BorderRadius.only(
                      topLeft:const Radius.circular(12),
                      topRight:const Radius.circular(12),
                      bottomLeft: currentUserId! != userId ?const Radius.circular(0) :const Radius.circular(12),
                      bottomRight: currentUserId! == userId ?const Radius.circular(0) :const Radius.circular(12)
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: imageUrl != '' ? Container(
                                child: Image.network(
                                 imageUrl!,
                                  fit: BoxFit.fitWidth,
                                ),
                                height: 150,
                                width: 150.0,
                                // color:const Color.fromRGBO(0, 0, 0, 0.2),
                                padding:const EdgeInsets.all(5),
                              ): Column(
                      crossAxisAlignment:currentUserId == userId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                      CustomText(text: text, color:currentUserId == userId ? Colors.white : Colors.black ,size: 12.sp,),
                      SizedBox(height: MediaQuery.of(context).size.height / 90),
                       Row(
                        mainAxisAlignment:currentUserId == userId ? MainAxisAlignment.end : MainAxisAlignment.start,
                         children: [
                           CustomText(text: HelperFunctions.getFormattedTime(context: context, time: time ?? ""),size: 10.sp,color: Colors.grey,),
                           const SizedBox(width: 3,),
                          currentUserId == userId ?
                           isRead == true ?
                           const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20) : const Text('') : const Text(''),
                         ],
                       )               
                      //Text(DateFormat('h:mm a',).format(dateTime),style:TextStyle(color:currentUserId == userId ? Colors.white : Colors.black,fontFamily: 'Core Pro'))                   
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
