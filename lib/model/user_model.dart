
class UserModel{
  String? authType;
  dynamic userCreated;
  String? userEmail;
  String? password;
  String? fullName;
  String? userId;
  String? userLastSeen;
  String? userStatus;
  String? profilePicture;
  int? totalPost;
  String? userRole;
  bool? isPremium;
  // final DocumentReference? reference;


  UserModel({
    this.authType,
    this.totalPost,
    this.userCreated,
    this.userEmail,
    this.userLastSeen,
    this.userId,
    this.userStatus,
    this.fullName,
    this.password,
    this.userRole,
    this.profilePicture,
    this.isPremium
    // this.reference
  });

  UserModel.fromJson(Map<String, dynamic> map, )
      : userId = map['userId'],
        userEmail = map["userEmail"],
        userCreated = map["userCreated"],
        userStatus = map["userStatus"],
        fullName = map["fullName"],
        userRole = map["userRole"],
        password = map["password"],
        profilePicture = map["profilePicture"],
        isPremium =map["isPremium"],
        authType = map["authType"]; 


  Map<String, dynamic> toJson(){
    return {
    'userAuthType': authType,
    'userCreated': userCreated,
    'userEmail': userEmail,
    'userId' : userId,
    'userStatus': userStatus,
    'fullName': fullName,
    'password': password,
    'profilePicture' : profilePicture,
    'isPremium': isPremium,
    'userRole': userRole
    };
  }
  

  // UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
  //  : userId = doc.id,
  //    userEmail = doc.data()!["userEmail"],
  //    userCreated = doc.data()!["userCreated"],
  //    userStatus = doc.data()!["userStatus"],
  //    fullName = doc.data()!["fullName"],
  //    userRole = doc.data()!["userRole"],
  //    password = doc.data()!["password"],
  //    authType = doc.data()!["authType"];  
//    UserModel.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);
 }