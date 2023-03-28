import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/reset_password_view_model.dart';
import 'package:red_flag/widgets/custom_form_field.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({ Key? key }) : super(key: key);
  static String routeName = "/reset-password";
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Consumer<ResetPasswordViewModel>(
        builder: (context,provider,child) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            padding:kPadding,
          decoration:const BoxDecoration(
              color:kFormBackround,
          ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const SizedBox(height: 150,),
                  CustomText(text: "ResetPassword Account",size:22.sp,weight: FontWeight.w700,color:Colors.white),
                  const SizedBox(height: 35,),
                  CustomText(text: "Enter Email / No. Phone to ResetPassword",size:13.sp,weight: FontWeight.w400,color:const Color(0xFFACACAC)),
                  const SizedBox(height: 54,),
                   TextFieldC(
                    controller: provider.emailTex,
                    text:"Email/phone" ,
                    onChanged: (value){},
                    validFunction: (value){
                      String? errorMessage;
                    if (value!.isEmpty) {
                      errorMessage = "\u26A0 email is required";
                    } else if (!emailValidatorRegExp.hasMatch(value)) {
                        errorMessage = "\u26A0 Invalid Email Address";
                    }
                  return errorMessage;
                    },         
                  ),
                  const SizedBox(height:25),
                  Padding(
                    padding: kPadding,
                    child: ButtonWidget(text:provider.isLoading ? "Loading...." : "Continue",press:provider.isLoading ? null : () async{
                      if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await provider.resetPassword(context);
                    }
                    },color:const Color(0xFF3669C9),),
                  ),
                  const SizedBox(height:20),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: "Have an Account?",size:14.sp,color:Colors.white,weight:FontWeight.w700),
                      const SizedBox(width:8),
                      CustomText(text: "Sign in",color:Colors.blue,size:14.sp),
                    ],
                  )
              
              
                  
              
                  
              
                ],),
                      ),
              ) );
        }
      ),
      
    );
  }
}