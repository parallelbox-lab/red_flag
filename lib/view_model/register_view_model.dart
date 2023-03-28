import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:red_flag/data/services/upload_image.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/user_model.dart';
import 'package:red_flag/screens/auth/login/login.dart';
import 'package:red_flag/screens/bottom_navigation.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/image_selector.dart';
import 'package:red_flag/widgets/common.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../data/repository/base_auth.dart';

class AuthViewModel extends ChangeNotifier{
  bool checkNetwork = false;
  bool _isLoading = false;
  // final NetWorkInfo? netWorkInfo;
  bool _profileEdit = false;
  bool get profileEdit => _profileEdit;

  bool get isLoading => _isLoading;

  AuthBase auth = Auth();
  bool? email;
  bool? fullname;
  bool? password;
  TextEditingController emailTex = TextEditingController();
  TextEditingController fullnameTex = TextEditingController();
  TextEditingController passwordTex = TextEditingController();
  
  void loading(bool loading){
   _isLoading = loading;
   notifyListeners();
  }
  set profileEdit(bool loading){
   _profileEdit = loading;
   notifyListeners();
  }

ImageSelector imageSelector = ImageSelector();

//  Future<void> login (String email, String password, BuildContext context) async {
//    loading(true);
//   // NetworkHandler.networkCheck().then((value) => {
//   //   value == true ? checkNetwork = true : checkNetwork = false,
//   // });
//   // notifyListeners();

//   // if(checkNetwork == true){
//   try{
//    var user = await auth.signIn(email, password);
//   //  if(user.user != null){}
//    await auth.getUserProfile(user.user?.uid);
//    emailTex.text = "";
//    passwordTex.text = "";
//    loading(false);
//    if(user.user != null){
//    _isBack = true;
//    }

//    notifyListeners();

//   } on FirebaseAuthException catch(e){
//     loading(false);
//       print(e.message);
//     showerrorDialog(e.message ?? "",context);
//     //  errorToast(AuthExceptionHandler.generateExceptionMessage(e.toString()));
//   }
//    catch(e){
//     loading(false);
//     // errorToast(AuthExceptionHandler.generateExceptionMessage(e.toString()));
//     // rethrow;
//   }
//   // }else{
//   //   errorToast("No Internet Connection");
//   //   loading(false);
//   // }
   
  
//  }
 Future<void> createAccount(String email, String password, String fullName,File? image, BuildContext context) async {
  loading(true);
  try{
  final imageUrl = await UploadImage.uploadImage(image:image);
   var user = await auth.signUp(email, password,fullName);
   if(user.user != null){}
   UserModel userModel = UserModel(
    totalPost: 0,
    userEmail: emailTex.text,
    userId: user.user?.uid,
    fullName: fullnameTex.text,
    password: passwordTex.text,
    profilePicture: imageUrl,
    isPremium: false,
    authType: "Email",
    userStatus: "Online",
    userRole: "Users",
    // userCreated: DateTime.now()
   );
   await auth.createUserProfile(userModel);
   await Purchases.logIn(UserData.getUserId() ?? "");
   emailTex.text = "";
   passwordTex.text = "";
   fullnameTex.text = "";
   imageSelector.imageFile == null;

  if(user.user != null){
    Navigator.pushNamedAndRemoveUntil(context, BottomNavigation.routeName, (route) => false);
  }
  notifyListeners();
  } on FirebaseAuthException catch(e){
    loading(false);
    showerrorDialog(e.message ?? "Error Occured", context, false);
  } 
   catch(e){
    loading(false);
    showerrorDialog("An Error Occured, try again", context, false);
    rethrow;
  }
 }


Future logout(BuildContext context) async {
  try{
    if(UserData.authType() == "Google"){
    
    }
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
  }catch(e){
    rethrow;
  }
  // _sharedPreferences?.remove("loginStatus"); 
}
Future deleteProfile(BuildContext context) async {
  try{
    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    if(isConnected == true) {
    await auth.deleteUser();
    Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
    showerrorDialog("Account Deleted Successfuly", context, true); 
    } else {
      showerrorDialog("No network connection 😞", context, false); 
    }
  }catch(e){
    rethrow;
  }
  // _sharedPreferences?.remove("loginStatus"); 
}
Future<void> editProfile(BuildContext context,{File? imageFile, String? fullName}) async {
  try{
  bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
  profileEdit = true;
   if(isConnected == true) {
   if(imageFile != null){
      String? imageUrl;
     imageUrl = await UploadImage.uploadImage(image: imageFile);
      await auth.editUserProfile(
        imageFile: imageUrl,
        fullName: fullName
      );
   } else {
    await auth.editUserProfile(
    fullName: fullName);
 } 
  notifyListeners();
  profileEdit = false;
  showAlertDialog(context,message: "User Profile Edited successfuly", press: (){
     Navigator.pushNamedAndRemoveUntil(context, BottomNavigation.routeName, (route) => false);
    });
   } else {
    showerrorDialog("No network connection 😞", context, false);
   }
  } catch(e){
    profileEdit = false;

  }

}

Future<void> signiInWithGoogle(BuildContext context) async {
 try{
  loading(true);
  if(isLoading){
    showLoadingDialog(context,loading: _isLoading);
  }
  final user = await auth.googleSigIn();
  await Purchases.logIn(user);
  loading(false);
   if(!isLoading){
    Navigator.pop(context);
   }
   if(user.isNotEmpty) {
    Navigator.pushNamedAndRemoveUntil(context, BottomNavigation.routeName, (route) => false);
   } 
   // showerrorDialog("Google Signin not completed, try again", context);
   notifyListeners();
  } catch(e) {
   loading(false);
   if(!isLoading){
    Navigator.pop(context);
   }
    showerrorDialog("Try Again", context, false);
       rethrow;
 }
}


Future<void> signInWithApple(BuildContext context,{List<Scope> scopes = const []}) async {
 try{
  loading(true);
  if(isLoading){
    showLoadingDialog(context,loading: _isLoading);
  }
  final user = await auth.appleSignIn(scopes: [Scope.email, Scope.fullName]);
  await Purchases.logIn(user);
  loading(false);
   if(!isLoading){
    Navigator.pop(context);
   }
   if(user.isNotEmpty) {
    Navigator.pushNamedAndRemoveUntil(context, BottomNavigation.routeName, (route) => false);
   } 
   // showerrorDialog("Google Signin not completed, try again", context);
   notifyListeners();
  } catch(e) {
   loading(false);
   if(!isLoading){
    Navigator.pop(context);
   }
    showerrorDialog("Try Again", context,false);
       rethrow;
 }
}


@override
  void dispose() {
  emailTex.dispose();
  fullnameTex.dispose();
  passwordTex.dispose();
  super.dispose();
  }
}