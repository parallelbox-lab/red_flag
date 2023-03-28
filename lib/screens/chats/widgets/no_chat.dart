import 'package:flutter/material.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class NoChat extends StatelessWidget {
  const NoChat({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/Worried-rafiki 1.png"),
          // const SizedBox(height:10),
        CustomText(text: "You Dont Have Any Previous Chat",textAlign: TextAlign.center,size:15.sp),
        const SizedBox(height:20), 
      ],
          
    );
  }
}