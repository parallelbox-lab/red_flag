import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String? id;
  Map<String, dynamic>? senderDetails;
  Map<String, dynamic>?lastMessages ;
  List<dynamic>? users;

Conversation({
  this.lastMessages,
  this.senderDetails,
  this.users,
  this.id
});

  factory Conversation.fromFireStore(DocumentSnapshot doc) {
    final Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Conversation(
        senderDetails: map['senderDetails'],
        lastMessages: map['lastMessage'],
        users: map['users'],
        id: map['id']
    );
  }

Conversation.fromJson(Map<String,dynamic> map,)
  : senderDetails = map['senderDetails'],
    lastMessages = map['lastMessage'],
    id = map['id'],
    users = map['users'];

   Map<String, dynamic> toJson(){
    return{
      'senderDetails' : senderDetails,
      'lastMessage' : lastMessages,
      'id' : id,
      'users' : users
     };
   }
}