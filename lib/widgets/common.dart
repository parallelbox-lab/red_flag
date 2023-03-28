import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
void snackBarNetwork({String? msg, GlobalKey<ScaffoldState>? scaffoldState}) {
  // Fluttertoast.showToast(
  //       msg: msg!,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //   );
}

  showerrorDialog(String errrorMessage, BuildContext context,bool? status) {
    Flushbar(
      backgroundColor:status == true ? Colors.green : Colors.red ,
      flushbarPosition: FlushbarPosition.TOP,
      title: status == true ?'':'An error occured',
      message: errrorMessage.toString(),
      duration: const Duration(seconds: 10),
    ).show(context);
  }
 showAlertDialog(BuildContext context, {String? message, Function? press}) {
  AlertDialog alert = AlertDialog(
    content: WillPopScope(
      onWillPop: () async => false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
             Image.asset("assets/icons/tick-circle.png",width:90),
              const SizedBox(height: 7,),
              CustomText(text:message, size:14.sp,weight:FontWeight.w600,textAlign: TextAlign.center,),
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left:17.0,right:17.0),
                child: ButtonWidget(text: "Continue",press:press as void Function()?),
              )
        ],
      ),
    ),
   
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLoadingDialog(BuildContext context, {bool? loading}) {
  AlertDialog alert = AlertDialog(
    content: WillPopScope(
      onWillPop: () async => false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Platform.isAndroid ? const CircularProgressIndicator(
                  strokeWidth: 1.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)): const CupertinoActivityIndicator(color: Colors.blue,),            
        ],
      ),
    ),
   
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
void successToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      // webPosition: ,
      fontSize: 13.0.sp);
}
void errorToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      // webPosition: ,
      fontSize: 11.0.sp);
}