import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:red_flag/data/enums/payment_plan.dart';
import 'package:red_flag/screens/payment_page_view/payment_page_view.dart';
import 'package:red_flag/view_model/subscription_view_model.dart';
import 'package:red_flag/widgets/common.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../data/services/user_data.dart';

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({ Key? key }) : super(key: key);

  @override
  State<PaymentPlan> createState() => _PaymentPlanState();
}

class _PaymentPlanState extends State<PaymentPlan> {
  PaymentType? _paymentType;
  int? amount;
  bool isLoading = false;
  bool isLoading2 = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<SubscriptionViewModel>(
      builder: (context, vm, child) {
        return Container(
          padding:const EdgeInsets.all(17),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Choose your Plan",weight: FontWeight.w700,size:15.sp,color:Colors.black),
              const SizedBox(height: 5,),
              GestureDetector(
                onTap: () async {
                  try{
                  setState(() => isLoading = true);
                  await Purchases.purchaseProduct("redflag_4_1m"); 
                  await vm.updateSubscriptionStatus(status:true);
                  await vm.savePaymentDetails(context, amount: "4");
                  setState(() => isLoading = false);
                  } catch (e){
                    setState(() => isLoading = false);
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    showerrorDialog(e.toString(), context,false);

                  }
                },
                child: Container(
                  width: double.infinity,
                  padding:const EdgeInsets.all(15),
                  decoration:const BoxDecoration(
                    color:  Color(0xFF3F37C9),
                    borderRadius: BorderRadius.all(Radius.circular(55))
                    
              
                  ),
                  
                  child:isLoading ? Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator(color: Colors.white,)) : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,                    children: [
                      CustomText(text: "\$4/month",weight:FontWeight.w700,size:12.sp,color: Colors.white,),
                      CustomText(text: "Then 4\$ per month. cancel anytime ",color: Colors.white,size:12.sp),
                    ],
                  ),
                 
                ),
              ),
             const SizedBox(height: 10,),
             GestureDetector(
                onTap: () async {
                  try{
                  setState(() => isLoading2 = true);
                  await Purchases.purchaseProduct("redflag_38_1y");
                  await vm.updateSubscriptionStatus(status:true);
                  await vm.savePaymentDetails(context, amount: "38");
                  setState(() => isLoading2 = false);
                  } catch (e){
                    setState(() => isLoading2 = false);
                    //showerrorDialog("Unable to Process Payment, try again", context);
                  }
                
                },
                child: Container(
                  width: double.infinity,
                  padding:const EdgeInsets.all(11),
                  decoration:const BoxDecoration(
                    color: Color(0xFF3F37C9),
                    borderRadius: BorderRadius.all(Radius.circular(55))),                  
                  child:isLoading2 ? Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator(color: Colors.white,)) : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CustomText(text: "Yearly".toUpperCase(), size: 11.sp,color: Colors.white,),
                      // SizedBox(height: size.height / 100),
                      CustomText(text: "\$38/yearly",weight:FontWeight.w700,size:12.sp,color: Colors.white,),
                      CustomText(text: "Then 38\$ per year. cancel anytime ",color: Colors.white,size:12.sp),
                    ],
              ))),  

            //  Card(
            //     shape:RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //     child: RadioListTile(
            //     controlAffinity: ListTileControlAffinity.trailing,
            //       value: PaymentType.yearly, groupValue: _paymentType, onChanged: (PaymentType? value) {
            //         if(value == PaymentType.yearly){
            //         setState((){
            //         _paymentType = value!;
            //           amount = 38;
            //         });
            //        }
            //       },
            //      title: CustomText(text: "Yearly".toUpperCase(), size: 11.sp,),
            //      subtitle:Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //        children: [
            //         const SizedBox(height: 15,),
            //         CustomText(text: "\$38/yearly",weight:FontWeight.w700,size:12.sp,color:Colors.black),
            //         const SizedBox(height: 10,),
            //          CustomText(text: "then 38\$ per year. cancel anytime ",size:12.sp),
            //        ],
            //      ),
            //     ),
            //   ),


            ],
           ),
            const SizedBox(height: 10,),
            //  Container(
            // padding:const EdgeInsets.only(left: 15,right: 15),
            // margin: const EdgeInsets.only(bottom: 5.0),
            // width: double.infinity,
            // height: 55.0,
            // child: TextButton(
            //     style: TextButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30.0)),
            //       primary: Colors.white,
            //       backgroundColor: const Color(0xFF3F37C9),
            //     ),
            //     onPressed:amount == null ? ()=> showerrorDialog("Kindly select a payment plan",context) : ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> PaymentPageView(amount:amount ?? 0 ,))),
            //     child: Text("Make Payment",
            //         style: TextStyle(
            //             fontFamily: 'Core Pro',
            //             fontSize: 13.0.sp,
            //             fontWeight: FontWeight.w500,
            //             color:Colors.white),
            //         textAlign: TextAlign.center)))

          ],),
        );
      }
    );
  }
}