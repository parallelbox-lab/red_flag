import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
        GestureDetector(
                // onTap: () => Navigator.pushNamed(context, Notifications.routeName),
                child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,color:Colors.white)),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomText(text: UserData.fullName()),
        )
      ]),
      body:SingleChildScrollView(
        child: Padding(
          padding: kPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CustomText(text: "Overview", size: 18.sp,weight: FontWeight.w700,),
            const SizedBox(height: 20,),
            GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20,
            children: [
               Card(
                  // shape: BorderSide(width: ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 5,),
                          CustomText(text: "Users",size:13.sp),
                          const Spacer(),
                          const Icon(Icons.spa)
                        ],),
                        const Spacer(),
                      CustomText(text: '3.5K', size:20.sp, weight:FontWeight.w800),
                      CustomText(text: "Users",size:13.sp),
                    ],),
                  ),
                ),

               Card(
                  // shape: BorderSide(width: ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 5,),
                          CustomText(text: "Users",size:13.sp),
                          const Spacer(),
                          const Icon(Icons.spa)
                        ],),
                        const Spacer(),
                      CustomText(text: '3.5K', size:20.sp, weight:FontWeight.w800),
                      CustomText(text: "Users",size:13.sp),
                    ],),
                  ),
                ),

               Card(
                  // shape: BorderSide(width: ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 5,),
                          CustomText(text: "Users",size:13.sp),
                          const Spacer(),
                          const Icon(Icons.spa)
                        ],),
                        const Spacer(),
                      CustomText(text: '3.5K', size:20.sp, weight:FontWeight.w800),
                      CustomText(text: "Users",size:13.sp),
                    ],),
                  ),
                ),
               Card(
                  // shape: BorderSide(width: ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 5,),
                          CustomText(text: "Users",size:13.sp),
                          const Spacer(),
                          const Icon(Icons.spa)
                        ],),
                        const Spacer(),
                      CustomText(text: '3.5K', size:20.sp, weight:FontWeight.w800),
                      CustomText(text: "Users",size:13.sp),
                    ],),
                  ),
                ),
              
            ],
            )
      
          ],),
        ),
      )
    );
  }
}