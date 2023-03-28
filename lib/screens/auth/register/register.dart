
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/screens/auth/login/login.dart';
import 'package:red_flag/screens/auth/profile_password/profile_password.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/custom_form_field.dart';
import 'package:red_flag/view_model/register_view_model.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);
  static String routeName = "/register";
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
        padding:kPadding,
      decoration:const BoxDecoration(
          color:kFormBackround,
      ),
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 150,),
              CustomText(text: "Register Account",size:22.sp,weight: FontWeight.w700,color:Colors.white),
              const SizedBox(height: 35,),
              CustomText(text: "Enter Email / No. Phone to register",size:13.sp,weight: FontWeight.w400,color:const Color(0xFFACACAC)),
              const SizedBox(height: 54,),
               TextFieldC(
                controller:provider.emailTex,
                text:"Email/Phone" ,
                placeHolderText: "E.g Adeoluwa@gmail.com",
                onChanged: (value){
                   value = provider.emailTex.text;              
                    setState(
                      () {
                      if (value.isNotEmpty||!emailValidatorRegExp.hasMatch(value)) {
                        provider.email = true;
                      } else {
                        provider.email = false;
                      }
                        },
                      ); 
                },
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
                child: ButtonWidget(text:"Continue",press: (){
                if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                  Navigator.pushNamed(context, ProfilePassword.routeName);
                }
              },color:const Color(0xFF3669C9),),
  
              ),
              const SizedBox(height:20),
              InkWell(
                onTap: () => Navigator.pushNamed(context, Login.routeName),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "Have an Account?",size:14.sp,color:Colors.white,weight:FontWeight.w700),
                    const SizedBox(width:8),
                    CustomText(text: "Sign in",color:Colors.blue,size:14.sp),
                  ],
                ),
              )
        
        
              
        
              
        
            ],),
        ),
        ) ),
      
    );
  }
}