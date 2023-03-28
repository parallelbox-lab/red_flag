import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/make_payment.dart';
import 'package:sizer/sizer.dart';

class QuestionaireResult extends StatelessWidget {
  const QuestionaireResult({ Key? key,this.result, this.percentage }) : super(key: key);
  final String? result;
  final String? percentage;
  @override
  Widget build(BuildContext context) {
    final value = int.parse(percentage ?? "")/100;
    return Scaffold(
     
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Center(child: Row(
                children: [
                  const BackButton(),
                  const SizedBox(width: 20,),
                  CustomText(text: "Questionaire Result", size:19.sp, weight: FontWeight.w700,),
                ],
              )),
              const SizedBox(height: 20,),
                CustomText(text: "There is always someone to talk to no matter what the world says, or who they say you should talk to, you can find that person, confidante, and friend to talk to, you are never alone".toUpperCase(),size: 11.sp,textAlign: TextAlign.center,),
             const  SizedBox(height: 15,),
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: Container(
                height: MediaQuery.of(context).size.height * 0.23,
                decoration: BoxDecoration(
                  color:const Color(0xffE5E5E5),
                  borderRadius: BorderRadius.circular(15)
                ),
                padding:const EdgeInsets.all(30),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const CustomText(text: "Health",),
                        CustomText(text:"$percentage%")

                      ],
                    ),
                   const Spacer(),
                   LinearProgressIndicator(
                                  backgroundColor: const Color(0xffFF0000),
                                  value:value,
                                  minHeight:7,
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff00A35E))),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text:"Bad",size: 10.sp,),                 
                        CustomText(text:'Good',size: 10.sp,)

                      ],
                    ),
                                  
                  //   Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //   gradient:const LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.topRight,
                  //     colors: [ Color(0xffFF0000),Color(0xffE6E939),Color(0xff00A35E),]
                  //   ),
                  // ),
                  //     child:const SizedBox(
                  //       height: 20.0,
                  //     ),
                  //   ),
                  //   const SizedBox(height: 10,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     CustomText(text:result!.contains("bad") ? "Bad" : "",size: 10.sp,),
                    //     CustomText(text:result!.contains("okay") ? "Okay" : '',size: 10.sp,),
                    //     CustomText(text:result!.contains("good") ? "Good" : '',size: 10.sp,),
                    //     CustomText(text:result!.contains("excellentt") ? "Excellent" : '',size: 10.sp,)

                    //   ],
                    // ),

                  
                  ],
                ) ,
               ),
             ),
              // CustomText(text: "Your Current Mood Situation is  " + result!,weight: FontWeight.w800,),
              const SizedBox(height: 50),
              const  Spacer(),
           UserData.getPremium() == false ?
              Column(
                children: [
                  const CustomText(text: 'To get full question for suicide analysis please purchase our premium subscription'),
                  const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: ButtonWidget(
                  text: "Subscribe to Premium",
                  press: ()=> showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
        context: context,
        enableDrag: true,
        builder: (context) => const MakePayment()))
     ,
                ),
              
                ],
              ) : Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: ButtonWidget(
                  text: "Close",
                  press: ()=> Navigator.pop(context),)),
              
              ],
            ),
          ),
        ),
      
    );
  }
}