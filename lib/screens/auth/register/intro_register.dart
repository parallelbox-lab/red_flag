import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/apple_signin_checker.dart';
import 'package:red_flag/screens/auth/login/login.dart';
import 'package:red_flag/screens/auth/register/register.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/register_view_model.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:the_apple_sign_in/apple_sign_in_button.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class IntroRegister extends StatelessWidget {
  const IntroRegister({ Key? key }) : super(key: key);
  static String routeName="/intro-register";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context);
      final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    final size = MediaQuery.of(context).size; 
    return Scaffold(
      backgroundColor:kFormBackround,
      body: Padding(
        padding: kPadding,
        child: Stack(
          // alignment: Alignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [            
          Positioned.fill(
            // bottom: 30,
            top: size.height / 8,
            child: Column(children: [
           CustomText(text: " “I can't control everything that happens to me, but I can control the way I respond to what happens”", size:17.sp,textAlign: TextAlign.center,color:Colors.white),
             const SizedBox(height:40),
           Platform.isAndroid ? Padding(
              padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width / 20, left:MediaQuery.of(context).size.width / 20),
              child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 16,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    primary: Colors.white,
                    backgroundColor:Colors.white,
                  ),
                  onPressed: ()=> provider.signiInWithGoogle(context),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   const CircleAvatar(radius:25,backgroundImage: AssetImage("assets/icons/google.png",),backgroundColor: Colors.transparent,),             
                           const SizedBox(width:1),
                      Text("Continue with Google",
                          style: TextStyle(
                              fontFamily: 'Core Pro',
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          textAlign: TextAlign.center),
                    ],
                  ))),
            ) : SizedBox(),
             if (appleSignInAvailable.isAvailable)
             Platform.isAndroid ? Padding(
                padding: const EdgeInsets.only(right:20.0, left:20),
                child: AppleSignInButton(
                 // style: ButtonStyle.black, // style as needed
                  type: ButtonType.signIn, // style as needed
                  onPressed: ()=> provider.signInWithApple(context,scopes: [Scope.email, Scope.fullName]),
                ),
              ): SizedBox(),
            // Padding(
            //   padding: const EdgeInsets.only(right:30.0, left:30),
            //   child: Container(
            //   margin: const EdgeInsets.only(bottom: 5.0),
            //   width: double.infinity,
            //   height: 50.0,
            //   child: TextButton(
            //       style: TextButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(25.0)),
            //         primary: Colors.white,
            //         backgroundColor:Colors.white,
            //       ),
            //       onPressed: (){},
            //       child: Row(mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //         const CircleAvatar(radius:25,backgroundImage: AssetImage("assets/icons/facebook.png"),backgroundColor: Colors.transparent,),
            //          const SizedBox(width:5),
            //           Text("Continue with Facebook",
            //               style: TextStyle(
            //                   fontFamily: 'Core Pro',
            //                   fontSize: 11.0.sp,
            //                   fontWeight: FontWeight.w700,
            //                   color: Colors.black),
            //               textAlign: TextAlign.center),
            //         ],
            //       ))),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right:30.0, left:30),
            //   child: Container(
            //   margin: const EdgeInsets.only(bottom: 5.0),
            //   width: double.infinity,
            //   height: 50.0,
            //   child: TextButton(
            //       style: TextButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(25.0)),
            //         primary: Colors.white,
            //         backgroundColor:Colors.white,
            //       ),
            //       onPressed: (){},
            //       child: Row(mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //         const CircleAvatar(radius:25,backgroundImage: AssetImage("assets/icons/apple.png"),backgroundColor: Colors.transparent,),
            //          const SizedBox(width:1),
            //           Text("Continue with Apple",
            //               style: TextStyle(
            //                   fontFamily: 'Core Pro',
            //                   fontSize: 11.0.sp,
            //                   fontWeight: FontWeight.w700,
            //                   color: Colors.black),
            //               textAlign: TextAlign.center),
            //         ],
            //       ))),
            // ),
        // Platform.isIOS ?  Container(
        //   padding: const EdgeInsets.all(10),
        //   child: Center(
        //     child: SignInWithAppleButton(
        //       onPressed: () async {
                

        //         // final session = await http.Client().post(
        //         //   signInWithAppleEndpoint,
        //         // );

        //         // If we got this far, a session based on the Apple ID credential has been created in your system,
        //         // and you can now set this as the app's session
        //         // ignore: avoid_print
        //         //print(session);
        //       },
        //     ),
        //   ),
        // ) : const Text(''),
          
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
              Platform.isAndroid ?    CustomText(text: "OR",size:13.sp,color:Colors.white) : SizedBox(),
               Platform.isAndroid ?   Expanded(
                    child:  Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Platform.isAndroid ?Divider(
                          color: Colors.white,
                          height: 36,
                          thickness:2
                        ): SizedBox()) ,
                  ) : SizedBox(),
                ]),
                Padding(
                 padding: const EdgeInsets.only(right:30.0, left:30),
                  child: ButtonWidget(text: "Create Account",press:()=> Navigator.pushNamed(context, Register.routeName),color:Colors.blue,textColor: Colors.white,),
                ),
                const SizedBox(height:5),
                CustomText(text: "By signing up, you’ll agree to our Terms & Conditions and Privacy Policy",color: Colors.white,size:14.sp, textAlign: TextAlign.center,),
                const Spacer(),
                InkWell(
                  onTap: ()=> Navigator.pushNamed(context, Login.routeName),
                  child: CustomText(text: "Have an Account?  Sign in",color: Colors.white,size:14.sp, textAlign: TextAlign.center,))
                ],),
          )
            
            


          ],
        ),
      ),
      
    );
  }
}