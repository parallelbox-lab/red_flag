import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:red_flag/screens/auth/profile_password/profile_password.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Verification extends StatefulWidget {
  const Verification({ Key? key }) : super(key: key);
  static String routeName = "/verification";
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  // bool _pin1 = false;
  // bool _pin2 = false;
  // bool _pin3 = false;
  // bool _pin4 = false;
  // bool _pin5 = false;
  // bool _pin6 = false;
  // bool _isLoading = false;
  // bool _resendOtpLoading = false;
  // key for dialog when resend otp is activated
  final GlobalKey closeContext = GlobalKey<NavigatorState>();
  // key for dialog after otp resend is successful
  final closeContext2 = GlobalKey<NavigatorState>();
  // final TextEditingController _pin1Controller = TextEditingController();
  // final TextEditingController _pin2Controller = TextEditingController();
  // final TextEditingController _pin3Controller = TextEditingController();
  // final TextEditingController _pin4Controller = TextEditingController();
 

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
        padding:kPadding,
      decoration:const BoxDecoration(
          color:kFormBackround,
      ),
          child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 150,),
            CustomText(text: "Verification",size:22.sp,weight: FontWeight.w700,color:Colors.white),
            const SizedBox(height: 35,),
             RichText(
                      text: TextSpan(
                          text:
                              'An OTP has been sent to olu***************@gmail.com\n',
                          style:TextStyle(
                              fontFamily: 'Core Pro',
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                              color:Colors.white),
                          children:const <TextSpan>[
                        TextSpan(
                          text: "Didnt receive code?",
                          style: TextStyle(
                              fontFamily: 'Core Pro',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ])),
            
           const SizedBox(height:110),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Verification Code",size:13.sp,weight: FontWeight.w400,color:Colors.white),
                  CustomText(text: "Re-send code",size:13.sp,weight: FontWeight.w400,color:Colors.blue),           
                ],
              ),
          //  const SizedBox(height: 10,),
          //  Padding(
          //    padding: const EdgeInsets.only(left:25.0,right:25.0,bottom:15,top:20),
          //    child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       SizedBox(
          //         width: 55,
          //         height: 55,
          //         child: TextFormField(
          //         inputFormatters: [
          //             LengthLimitingTextInputFormatter(1),
          //           ],
          //           autofocus: true,
          //           controller: _pin1Controller,
          //           obscureText: false,
          //           // style: otpStyles,
          //           keyboardType: TextInputType.number,
          //           textAlign: TextAlign.center,
          //           decoration: otpInputDecoration,
          //           onChanged: (value) {
          //             nextField(value, pin2FocusNode);
          //             value = _pin1Controller.text;
          //             setState(
          //               () {
          //                 if (value.isNotEmpty) {
          //                   _pin1 = true;
          //                 } else {
          //                   _pin1 = false;
          //                 }
          //               },
          //             );
          //           },
          //         ),
          //       ),
          //       SizedBox(
          //         width: 55,
          //         height: 55,
          //         child: TextFormField(
          //         inputFormatters: [
          //             LengthLimitingTextInputFormatter(1),
          //           ],
          //           focusNode: pin2FocusNode,
          //           obscureText: false,
          //           controller: _pin2Controller,
          //           // style: otpStyles,
          //           keyboardType: TextInputType.number,
          //           textAlign: TextAlign.center,
          //           decoration: otpInputDecoration,
          //           onChanged: (value) {
          //             nextField(value, pin3FocusNode);
          //             value = _pin2Controller.text;
          //             setState(
          //               () {
          //                 if (value.isNotEmpty) {
          //                   _pin2 = true;
          //                 } else {
          //                   _pin2 = false;
          //                 }
          //               },
          //             );
          //           },
          //         ),
          //       ),
          //       SizedBox(
          //         width: 55,
          //         height: 55,
          //         child: TextFormField(
          //         inputFormatters: [
          //             LengthLimitingTextInputFormatter(1),
          //           ],
          //           focusNode: pin3FocusNode,
          //           controller: _pin3Controller,
          //           obscureText: false,
          //           // style: otpStyles,
          //           keyboardType: TextInputType.number,
          //           textAlign: TextAlign.center,
          //           decoration: otpInputDecoration,
          //           onChanged: (value) {
          //             nextField(value, pin4FocusNode);
          //             value = _pin3Controller.text;
          //             setState(
          //               () {
          //                 if (value.isNotEmpty) {
          //                   _pin3 = true;
          //                 } else {
          //                   _pin3 = false;
          //                 }
          //               },
          //             );
          //           },
          //         ),
          //       ),
          //       SizedBox(
          //         width: 55,
          //         height: 55,
          //         child: TextFormField(
          //         inputFormatters: [
          //                 LengthLimitingTextInputFormatter(1),
          //         ],
          //          focusNode: pin4FocusNode,
          //           controller: _pin4Controller,
          //           obscureText: false,
          //           // style: otpStyles,
          //           keyboardType: TextInputType.number,
          //           textAlign: TextAlign.center,
          //           decoration: otpInputDecoration,
          //           onChanged: (value) {
          //             nextField(value, pin5FocusNode);
          //             value = _pin4Controller.text;
          //             setState(
          //               () {
          //                 if (value.isNotEmpty) {
          //                   _pin4 = true;
          //                 } else {
          //                   _pin4 = false;
          //                 }
          //               },
          //             );
          //           },
          //         ),
          //       ),
               
          //     ],
          // ),
          //  ),
            
          //   // const SizedBox(height: 54,),
          //   //  TextFieldC(
          //   //   text:"Email/phone" ,
          //   //   onChanged: (value){},
          //   //   validFunction: (value){},         
          //   // ),
          //   const SizedBox(height:25),
          //   Padding(
          //     padding: kPadding,
          //     child: ButtonWidget(text:"Continue",press:()=> Navigator.pushNamed(context, ProfilePassword.routeName),color:const Color(0xFF3669C9),),
          //   ),                     
            
          ],),
        ) ),
      
    );
  }
}