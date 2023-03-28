import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:upgrader/upgrader.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key, this.nextScreen}) : super(key: key);
  static String routeName = "/splash";
  final Widget? nextScreen;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
 
  void _navigationPage() async {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => widget.nextScreen!));
    }
  //}
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => _navigationPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: kBlackColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                // height: 30.h,
                child: Image.asset('assets/images/logo.png',width:150),
              ),
            ),
            const SizedBox(height:10),
            Text("The Red Flags We\n Ignore",
          style: GoogleFonts.rancho(
            textStyle:TextStyle(
                  // letterSpacing: letterspacing,
                  fontSize: 20.sp,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
                  ),
                textAlign:TextAlign.center 
                  )
            // CustomText(text: "Red Flags",color:Colors.white)
          ],
        ),
    );
  }
}
