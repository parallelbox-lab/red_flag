import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

abstract class AuthBase {
 Future<UserCredential> signIn(String email, String password);
 Future<UserCredential> signUp(String email, String password, String fullName);
 Future<UserCredential> getCurrentUser();
 Future<void>signOut();
 Future<UserModel> getUserProfile(dynamic userId);
 createUserProfile(UserModel userModel);
 editUserProfile({String? imageFile, String? fullName});
 Future<void> resetPassword({String? email});
 Future<String> googleSigIn();
 Future<String> appleSignIn({List<Scope> scopes = const []});
 Future<bool> userExists(String userId);
 Future deleteUser();
}

class Auth extends  AuthBase{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static SharedPreferences? _sharedPreferences;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
   static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<UserCredential> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signIn(String email, String password) async {
     UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
     return userCredential;
  }

  @override
  Future<UserCredential> signUp(String email, String password, String fullName) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  return userCredential;
  }
 final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future deleteuser() {
    return userCollection.doc(UserData.getUserId()).delete();
  }
@override
Future deleteUser() async {
    try {
    final user = FirebaseAuth.instance.currentUser;
      await user?.delete();
      await deleteuser(); // called from database class
      _sharedPreferences?.clear();   
      return true;
    } catch (e) {
      return null;
    }
  }
  
  @override
   Future<UserModel> getUserProfile(userId) async {
    DocumentSnapshot snapshot = await _db.collection("UserData").doc(userId).get();
    UserModel userModel = UserModel.fromJson(
      (snapshot.data() as dynamic),
    );
    await _sharedPreferences?.setString("userId", userId);
    await _sharedPreferences?.setString("fullName", userModel.fullName ?? "");
    await  _sharedPreferences?.setString("userEmail", userModel.userEmail ?? "");
    await _sharedPreferences?.setString("userRole", userModel.userRole ?? "");
    await _sharedPreferences?.setString("authType", userModel.authType ?? "");
    await _sharedPreferences?.setBool("isPremium", userModel.isPremium ?? false);
    await _sharedPreferences?.setBool("isSignedIn", true);
    await _sharedPreferences?.setString("profilePicture", userModel.profilePicture ?? "");
    return userModel;
  }
  @override
   createUserProfile(UserModel userModel) async {
   await FirebaseFirestore.instance.collection("UserData").doc(userModel.userId!).set(
   userModel.toJson());
   await _sharedPreferences?.setString("userId",userModel.userId!);
   await _sharedPreferences?.setString("fullName", userModel.fullName ?? "");
   await _sharedPreferences?.setString("userEmail", userModel.userEmail ?? "");
   await _sharedPreferences?.setString("userRole", userModel.userRole ?? "");
   await _sharedPreferences?.setString("authType", userModel.authType ?? "");
   await _sharedPreferences?.setString("profilePicture", userModel.profilePicture ?? "");
   await _sharedPreferences?.setBool("isPremium", userModel.isPremium ?? false);
   await _sharedPreferences?.setBool("isSignedIn", true);
  }

  @override
  Future<bool> userExists(String userId) async =>
      (await FirebaseFirestore.instance.collection("UserData").where("userId", isEqualTo: userId).get()).docs.isNotEmpty;

  @override
  Future<void> signOut() async {
    _sharedPreferences?.clear();
    await _auth.signOut();
  }

  @override
  Future<void> resetPassword({String? email}) async {
   _auth.sendPasswordResetEmail(email: email ?? "");
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();


  @override
  Future<String> googleSigIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    if(googleAuth?.accessToken != null && googleAuth?.idToken != null ){
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      String uid = userCredential.user!.uid;
      if(userCredential.user != null){
        final check = await userExists(userCredential.user!.uid);
        if(check){
          await getUserProfile(userCredential.user!.uid);
        } else {
          final  _user = userCredential.user;
          UserModel userModel = UserModel(
            fullName: _user?.displayName,
            profilePicture: _user?.photoURL,
            isPremium: false,
            userEmail: _user?.email,
            totalPost: 0,
            userId: _user?.uid,
            authType: "Google",
            userStatus: "Online",
            userRole: "Users",
          );
         await createUserProfile(userModel);
        }

      }
      return uid;
    }
    return "";
  
  }

  @override
  editUserProfile({String? imageFile, String? fullName}) async {
    await _db.collection("UserData").doc(UserData.getUserId()).update({
      "fullName":fullName,
      "profilePicture":imageFile!.isEmpty ? UserData.getUserProfilePic() : imageFile });
   await _sharedPreferences?.setString("fullName", fullName ?? "");
   await _sharedPreferences?.setString("profilePicture", imageFile);
  }

  @override
  Future<String> appleSignIn({List<Scope> scopes = const []}) async {
      // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
            await _auth.signInWithCredential(credential);
     //   final firebaseUser = userCredential.user!;
      if(userCredential.user != null){
        final check = await userExists(userCredential.user!.uid);
        print("user fullname""${userCredential.user?.displayName}");
        if(check){
          await getUserProfile(userCredential.user!.uid);
        } else {
          final  _user = userCredential.user;
          UserModel userModel = UserModel(
            fullName: _user?.displayName,
            profilePicture: _user?.photoURL,
            isPremium: false,
            userEmail: _user?.email,
            totalPost: 0,
            userId: _user?.uid,
            authType: "Apple",
            userStatus: "Online",
            userRole: "Users",
          );
         await createUserProfile(userModel);
        }

      }

    //     if (scopes.contains(Scope.fullName)) {
    //       final fullName = appleIdCredential.fullName;
    //       if (fullName != null &&
    //           fullName.givenName != null &&
    //           fullName.familyName != null) {
    //        // final displayName = '${fullName.givenName} ${fullName.familyName}';
    //         // await firebaseUser.updateDisplayName(displayName);
    //         final check = await userExists(userCredential.user!.uid);
    //         print(check);
    //     if(check){
    //       await getUserProfile(userCredential.user!.uid);
    //     } else {
    //       final  _user = userCredential.user;
    //       print('userName''${_user?.displayName}');
    //       UserModel userModel = UserModel(
    //         fullName: _user?.displayName,
    //         profilePicture: _user?.photoURL,
    //         isPremium: false,
    //         userEmail: _user?.email,
    //         totalPost: 0,
    //         userId: _user?.uid,
    //         authType: "Apple",
    //         userStatus: "Online",
    //         userRole: "Users",
    //       );
    //      await createUserProfile(userModel);
    //     }
    //   }
    // }
        return userCredential.user!.uid ;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }

  //      UserCredential userCredential = await _auth.signInWithCredential(credential.);
  // String uid = userCredential.user!.uid;
  // return '';
  }
  
}