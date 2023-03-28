import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:red_flag/data/repository/chat_repository.dart';
import 'package:red_flag/model/chat_model.dart';
import 'package:red_flag/widgets/common.dart';

class ChatViewModel extends ChangeNotifier{
ChatRepositoryImpl chatRepositoryImpl = ChatRepositoryImpl();
List<Conversation> get messagesFromAll => _messagesFromAll!;
List<Conversation>? _messagesFromAll;
String getConversationID(String userID, String peerID) {
    return userID.hashCode <= peerID.hashCode 
      ? userID + '_' + peerID 
      : peerID + '_' + userID;
 } 
 void updateMessageRead(DocumentSnapshot doc, String convoId, String pid){
  try{
   chatRepositoryImpl.updateMessageRead(doc, convoId, pid);
  } catch (e){
    errorToast(e.toString());
  }
 }

 void sendMessage(
    String convoID,
    String id,
    String pid,
    String content,
    String fullName,
    String profilePicture,
    String timestamp,
    String? image,
    int unreadBadge
  ) {
   try {
      chatRepositoryImpl.sendMessage(convoID, id, pid, content, fullName,profilePicture, timestamp,image,unreadBadge);
    } catch(e){
      errorToast("Unable to send message");
    }
  }

  
 getMessages() {
  try{
   chatRepositoryImpl.getMessages();
  } catch(e){
    // print(e.toString());
    errorToast("Something went wrong, unable to show chat list");
  }

 }
}