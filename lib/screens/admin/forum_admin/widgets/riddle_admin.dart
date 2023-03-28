import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/screens/admin/forum_admin/widgets/create_riddles.dart';
import 'package:red_flag/view_model/riddle_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants.dart';
class RiddleAdmin extends StatefulWidget {
  const RiddleAdmin({ Key? key }) : super(key: key);

  @override
  State<RiddleAdmin> createState() => _RiddleAdminState();
}

class _RiddleAdminState extends State<RiddleAdmin> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<RiddleViewModel>().getRiddle());
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 
    return SingleChildScrollView(
      child: Padding(
        padding: kPadding / 2,
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: "Riddles", size: 18.sp,weight: FontWeight.w700,),
           Padding(
              padding: const EdgeInsets.only(right:3.0, left:3),
              child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              width:size.width  / 3,
              height: 60.0,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    primary: Colors.white,
                    backgroundColor:Colors.blue,
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const CreateRiddles())),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Icon(Icons.add, color:Colors.white),
                     const SizedBox(width:5),
                      Expanded(
                        child: Text("New Riddles",
                            style: TextStyle(
                                fontFamily: 'Core Pro',
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ))),
            ),
        ], ),
        Consumer<RiddleViewModel>(
             builder: (context,vm, child) {
               if(vm.isLoading){
                return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
               }
                   return CustomScrollView(                             
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    slivers: <Widget>[
                    SliverToBoxAdapter(
                      // you could add any widget
                    child: ListTile(
                    // contentPadding:const EdgeInsets.all(7),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: CustomText(text: "Name",size:14.sp,weight:FontWeight.w700)),
                        Expanded(child: CustomText(text: "Status",size:14.sp,weight:FontWeight.w700)),
                        Expanded(child: CustomText(text: "Created",size:14.sp,weight:FontWeight.w700)),
                        Expanded(child: CustomText(text: "Modified",size:14.sp,weight:FontWeight.w700)),
                      ],
                    ),
              ),
            ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                              final data = vm.riddleList[index];
                                return InkWell(
                                  onTap: () {
                                  
                                  },
                                  child: ListTile(
                                  // contentPadding:const EdgeInsets.all(7),
                                    //return  ListTile(
                                    
                                    title: Column(
                                      children: [
                                      const Divider(thickness: 2,),
                                      const SizedBox(height:10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                        //Flexible(child: CustomText(text:data.title,size:13.sp,color:kBlackColor,weight:FontWeight.w400,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                        Flexible(child: CustomText(text:"Published",size:13.sp,color:kBlackColor,weight:FontWeight.w400,textAlign: TextAlign.center,)),
                                        Flexible(child: CustomText(text:"Feb 22",size:13.sp,color:kBlackColor,weight:FontWeight.w400,textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                        Flexible(child: CustomText(text:"March 5",size:13.sp,color:kBlackColor,weight:FontWeight.w400,textAlign: TextAlign.center,)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount:vm.riddleList.length,
                        ),
                      ),
                    ],
                         );
                 })
    ],)));
  }
}