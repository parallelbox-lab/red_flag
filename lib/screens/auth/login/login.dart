import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/apple_signin_checker.dart';
import 'package:red_flag/screens/auth/register/intro_register.dart';
import 'package:red_flag/screens/auth/register/register.dart';
import 'package:red_flag/screens/auth/reset_password/reset_password.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/login_view_model.dart';
import 'package:red_flag/view_model/register_view_model.dart';
import 'package:red_flag/widgets/custom_form_field.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);
  static String routeName = "/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool password = false;
  bool _isVisible = false;
    final _formKey = GlobalKey<FormState>();
  // final TextEditingController _passwordController = TextEditingController();

  void passwordStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<LoginViewModel>(context);  
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
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
              const SizedBox(height: 65,),
                Text("welcome!",
             style: GoogleFonts.rancho(
            textStyle:TextStyle(
                  // letterSpacing: letterspacing,
                  fontSize: 26.sp,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
                  ),
                textAlign:TextAlign.center 
                  ),
              // CustomText(text: "welcome!",size:22.sp,weight: FontWeight.w700,color:Colors.white),
              const SizedBox(height: 20,),
              CustomText(text: "“I can't control everything that happens to me, but I can control the way I respond to what happens”",size:12.sp,weight: FontWeight.w400,color:Colors.white),
              const SizedBox(height: 35,),
               TextFieldC(
                controller: provider.emailTex,
                text:"Email" ,
                placeHolderText: "e.g user@example.com",
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
              const SizedBox(height:10),
               CustomText(text:"Password", size: 13.sp,color: Colors.white,weight:FontWeight.w400),
                  Container(
                  //height:62,
                  margin: const EdgeInsets.only(top: 15.0),
                  child: _buildPasswordField(provider.passwordTex),
                  ),   
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, ResetPassword.routeName),
                  child: CustomText(text:"Forgot Password?",size:12.sp,color:Colors.white))
              ],),
            const SizedBox(height:25),
            Row(children: <Widget>[
                Expanded(
                  child:  Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child:const Divider(
                        color: Colors.white,
                        height: 36,
                        thickness: 2,
                      )),
                ),
          Platform.isAndroid ? CustomText(text: "OR",size:13.sp,color:Colors.white) : SizedBox(),
          Platform.isAndroid  ?       Expanded(
                  child:  Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.white,
                        height: 36,
                        thickness:2
                      )),
                ) : SizedBox(),
              ]),
              const SizedBox(height: 10,),
             Platform.isAndroid ?  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<AuthViewModel>(
                  builder: (context,vm,child) {
                    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => vm.signiInWithGoogle(context),
                          child:const CircleAvatar(radius:25,backgroundImage: AssetImage("assets/icons/google.png",),backgroundColor: Colors.transparent,)),
                        // CircleAvatar(radius:25,backgroundImage: AssetImage("assets/icons/facebook.png"),backgroundColor: Colors.transparent,),'
                        if (appleSignInAvailable.isAvailable)
                         GestureDetector(
                          onTap: () => vm.signInWithApple(context),
                          child: const CircleAvatar(radius:25,backgroundImage: AssetImage("assets/icons/apple.png"),backgroundColor: Colors.transparent,)),
                      ],
                    );
                  }
                ),
              ) : SizedBox(),
        Padding(
          padding: kPadding,
          child: Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          width: double.infinity,
          height: 55.0,
          child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                primary: Colors.white,
                backgroundColor:const Color(0xFF3F37C9),
              ),
              onPressed:provider.isLoading ? null : () async {
                 if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await provider.login(provider.emailTex.text.trim(), provider.passwordTex.text.trim(), context);        
                    }
              },
              child:provider.isLoading ? const CupertinoActivityIndicator(color: Colors.white,) : Text("Sign in",
                  style: TextStyle(
                      fontFamily: 'Core Pro',
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.center))),
        ),
              // Padding(
              //   padding: kPadding,
              //   child: ButtonWidget(text:provider.isLoading ? "Loading..." : "Sign in", press:() async{
              //        if (_formKey.currentState!.validate()) {
              //       _formKey.currentState!.save();
              //       await provider.login(provider.emailTex.text.trim(), provider.passwordTex.text.trim(), context);        
              //     }
              //   },),
              // ),
             const SizedBox(height:7),
              InkWell(
                onTap: ()=> Navigator.pushNamed(context, IntroRegister.routeName),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "Don't have an account?",size:14.sp,color:Colors.white,weight:FontWeight.w700),
                    const SizedBox(width:8),
                    CustomText(text: "Sign up",color:Colors.blue,size:14.sp),
                  ],
                ),
              )  ],),
        ),
          
        ) ),
      
    );
  }
   
  TextFormField _buildPasswordField(TextEditingController passwordController) {
    return TextFormField(
      obscureText: _isVisible ? false : true,
      controller: passwordController,
      // onSaved: (newValue) =>  newValue!,
      onChanged: (value) {
        setState(
          () {
            if (value.isNotEmpty) {
              password = true;
            } else {
              password = false;
            }
          },
        );
      },
      validator: (value) {
        String? errorMessage;
        if (value!.isEmpty) {
          errorMessage = "\u26A0 Please Enter your password";
        } 
        return errorMessage;
      },
      decoration: InputDecoration(
        hintText: "e.g Password#1",
        filled: true,
        fillColor: Colors.white,
        // floatingLabelStyle: TextStyle(color:const Color(0xFF828282)),
        contentPadding:const EdgeInsets.only(left:10,bottom: 47 / 2),
        errorStyle: const TextStyle(
            fontFamily: 'Core Pro',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () => passwordStatus(),
          icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}