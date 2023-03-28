import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/data/services/user_data.dart';

abstract class ChatRepository{
 updateMessageRead(DocumentSnapshot doc, String convoId, String pid,);
 sendMessage(String convoID,
    String id,
    String pid,
    String content,
    String fullName,
      String profilePicture,
    String timestamp,  String? image, int unreadBadge
);
    
  Stream getMessages();
}


class ChatRepositoryImpl implements ChatRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  @override
 void updateMessageRead(DocumentSnapshot doc, String convoId,  String pid,) {
   final data =  _db.collection("messages")
    .doc(convoId)
    .get();
  data.then((value){ 
  if(pid == value["senderDetails"]["userId"]){
    _db
  .collection('messages')
    .doc(convoId)
    .update({
     "senderDetails.unreadBadge" :0,   
    },);
    final DocumentReference documentReference = _db
    .collection('messages')
    .doc(convoId)
    .collection(convoId)
    .doc(doc.id);
    documentReference.update(<String, dynamic>{'read': true},);
    
  } else {
    _db
    .collection('messages')
    .doc(convoId)
    .update(<String, dynamic>{
      "postOwnerDetails.unreadBadge": 0
    },);}
    });
  
  }

 @override
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
 ){
  final DocumentReference convoDoc =
        FirebaseFirestore.instance.collection('messages').doc(convoID);
    convoDoc.set(<String, dynamic>{
      'lastMessage': <String, dynamic>{
        'idFrom': id,
        'idTo': pid,
        'timestamp': timestamp,
        'content': content,
        'read': false
      },
      
      "id" : convoID,
      "postOwnerDetails": <String,dynamic>{
        "profileImage" : profilePicture,
        "fullName" : fullName,
        "userId" : pid,
       // "unreadBadge": unreadBadge,
        "typing": false
      },
      "senderDetails" :<String,dynamic>{
        "profileImage" : UserData.getUserProfilePic() ?? "",
        "fullName" : UserData.fullName() ?? "",
        "userId" :UserData.getUserId() ?? "",
      //  "unreadBadge": unreadBadge,
        "typing": false
      },
      'users': <String>[id, pid],
    }).then((dynamic success) {
      final DocumentReference messageDoc = FirebaseFirestore.instance
          .collection('messages')
          .doc(convoID)
          .collection(convoID)
          .doc(timestamp);
          messageDoc.set(
        //  messageDoc,
          <String, dynamic>{
            'idFrom': id,
            'idTo': pid,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'read': false
          },
        );

    //  });
    });
 }

  @override
  Stream getMessages() {
      return _db
      .collection('messages')
      .orderBy('lastMessage.timestamp', descending: true)
      .where('users', arrayContains: UserData.getUserId())
      .snapshots();
      // .map((QuerySnapshot list) => list.docs
      //     .map((DocumentSnapshot doc) => Conversation.fromFireStore(doc))
      //     .toList());
    //  return _db
    //   .collection('messages')
    //   .orderBy('lastMessage.timestamp', descending: true)
    //   .where('users', arrayContains: UserData.getUserId())
    //   .get()
    //   .then((value) => value.docs.map((e) => Conversation.fromJson(e.data())).toList());
  }
//   Stream<List<Conversation>> streamConversations(String uid) {
//   return _db
//       .collection('messages')
//       .orderBy('lastMessage.timestamp', descending: true)
//       .where('users', arrayContains: UserData.getUserId())
//       .snapshots()
//       .map((QuerySnapshot list) => list.docs
//           .map((DocumentSnapshot doc) => Conversation.fromFireStore(doc))
//           .toList());
// }
}