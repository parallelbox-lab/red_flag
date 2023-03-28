import 'package:flutter/material.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/payment_plan.dart';
import 'package:sizer/sizer.dart';

class MakePayment extends StatelessWidget {
  const MakePayment({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(17),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        const SizedBox(height: 10,),
        CustomText(text: "Get Access to Premium\nContents",weight: FontWeight.w800,size: 18.sp,textAlign: TextAlign.center,),
        const SizedBox(height: 10,),
        CustomText(text: "You will get access to all our platforms features. explore and watch affirmation videos, answer unlimited riddles questions and lots more.", size: 12.sp,textAlign: TextAlign.center,),
        const SizedBox(height: 40,),
        CustomText(text: "Starting at \$4/month",size:13.sp),
        const SizedBox(height: 10,),
         Container(
        padding:const EdgeInsets.only(left: 15,right: 15),
        margin: const EdgeInsets.only(bottom: 5.0),
        width: double.infinity,
        height: 55.0,
        child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              primary: Colors.white,
              backgroundColor: const Color(0xFF3F37C9),
            ),
            onPressed:(){
       showModalBottomSheet(      
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        context: context,
        enableDrag: true,
        builder: (context) => WillPopScope(
         onWillPop: () async {           
            return true;
          }, 
          child: const PaymentPlan()));
          },
            child: Text("Choose your plan",
                style: TextStyle(
                    fontFamily: 'Core Pro',
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.w500,
                    color:Colors.white),
                textAlign: TextAlign.center)))

      ],),
    );
  }
}