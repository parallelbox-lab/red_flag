import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:red_flag/data/repository/base_auth.dart';
import 'package:red_flag/screens/admin/admin_bottom_navigation.dart';
import 'package:red_flag/screens/bottom_navigation.dart';
import 'package:red_flag/widgets/common.dart';

import '../data/services/user_data.dart';

class LoginViewModel extends ChangeNotifier{
    bool _isBack = false;
  bool get isBack => _isBack;
  bool checkNetwork = false;
  bool _isLoading = false;
  // final NetWorkInfo? netWorkInfo;

  bool get isLoading => _isLoading;

  AuthBase auth = Auth();
  bool? email;
  bool? password;
  TextEditingController emailTex = TextEditingController();
  TextEditingController passwordTex = TextEditingController();
  
  void loading(bool loading){
   _isLoading = loading;
   notifyListeners();
  }

 Future<void> login (String email, String password, BuildContext context) async {
  loading(true);
  // NetworkHandler.networkCheck().then((value) => {
  //   value == true ? checkNetwork = true : checkNetwork = false,
  // });
  // notifyListeners();

  // if(checkNetwork == true){
  try{
   var user = await auth.signIn(email, password);
  //  if(user.user != null){}
  final data = await auth.getUserProfile(user.user?.uid);
  await Purchases.logIn(user.user?.uid ?? "");
   emailTex.text = "";
   passwordTex.text = "";
   loading(false);
   if(user.user != null){
   if(data.userRole == "Admin"){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> const AdminBottomNavigation()), (route) => false);
   } else {
    Navigator.pushNamedAndRemoveUntil(context, BottomNavigation.routeName, (route) => false);
   }
  }
   notifyListeners();
  } on FirebaseAuthException catch(e){
    loading(false);
    showerrorDialog(e.message ?? "",context, false);
  }
   catch(e){
    loading(false);
    // errorToast(AuthExceptionHandler.generateExceptionMessage(e.toString()));
    // rethrow;
  }
  // }else{
  //   errorToast("No Internet Connection");
  //   loading(false);
  // }
   
  
 }
 
}