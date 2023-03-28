import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/subscription_view_model.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_text.dart';

class PaymentSubscription extends StatefulWidget {
  const PaymentSubscription({ Key? key }) : super(key: key);
  static String routeName = "/payment-subscription";
  @override
  State<PaymentSubscription> createState() => _PaymentSubscriptionState();
}

class _PaymentSubscriptionState extends State<PaymentSubscription> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SubscriptionViewModel>().getSubscription(context));
  }
  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;        
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xffF5F8FA),
        iconTheme:const IconThemeData(color: Colors.black),
        title: CustomText(text: "Payments and Subcription",color:const Color(0xff000000) ,size:17.sp,weight: FontWeight.w400,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/payments.png", width: double.infinity,height: size.height * 0.29,),
              Consumer<SubscriptionViewModel>(
                builder: (context, vm ,child) {
                 if(vm.isLoading){
                  return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
                  }
                  if(vm.paymentList.isEmpty){
                    return Center(child: CustomText(text: "No Subscription made yet", size: 15.sp,),);
                  } else {
                  return ListView.separated(
                    itemCount: vm.paymentList.length,
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                    final data = vm.paymentList[index];
                     var parsedDate = HelperFunctions.getTime(data.paymentDate ?? "");
                      String convertedDate = DateFormat("yyyy-MM-dd HH:MM").format(parsedDate);
                      final dateTime = DateTime.parse(convertedDate);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                           Container(
                            height: size.height / 19,
                            width: size.width / 9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                              image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(data.profilePic ?? ""),
                              ),
                            ),
                  ),
                  SizedBox(width: size.width /40,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Subscription"),
                      SizedBox(height: size.height / 180,),
                      Container(
                        padding:const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        decoration: BoxDecoration(
                          color:const Color(0x263EB27B),
                          borderRadius: BorderRadius.circular(23)
                        ),
                        child: CustomText(text: data.status,size: 11.sp,color:const Color(0xff5F9829),),
                      ),

                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(text: "\$${data.amount}", size: 15.sp, color: Colors.black,weight: FontWeight.w700,),
                      SizedBox(height: size.height / 180,),
                      CustomText(text: DateTimeFormat.format(dateTime,format: 'M j'), size: 11.sp, color: const Color(0x99000000),weight: FontWeight.w400,),


                  ],)
                        ],
                      ),
                    );
                    
                  },
                  separatorBuilder: (context, index)=> const Divider(),
                  );
                }}
              )
      
            ],
          ),
        ),
      ),
    );
  }
}