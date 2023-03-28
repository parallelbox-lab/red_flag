import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/base_auth.dart';
import 'package:red_flag/widgets/common.dart';

import '../screens/auth/login/login.dart';

class ResetPasswordViewModel extends ChangeNotifier{
  bool _isLoading = false;
  // final NetWorkInfo? netWorkInfo;

  bool get isLoading => _isLoading;
  TextEditingController emailTex = TextEditingController();
  AuthBase auth = Auth();

void loading(bool loading){
   _isLoading = loading;
   notifyListeners();
  }
  Future<void> resetPassword(BuildContext context) async {
    try{
     auth.resetPassword(email: emailTex.text.trim());
      emailTex.text = "";
      showAlertDialog(context,message:"Password Reset Email sent, Kindly visit your mail to change password", press: ()=> Navigator.pushNamed(context, Login.routeName));
    } on FirebaseAuthException catch(e){
     showerrorDialog(e.toString(), context,false);
    } 
  }
}