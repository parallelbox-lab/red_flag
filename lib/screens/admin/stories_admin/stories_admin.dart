import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/admin/stories_admin/new_stories.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/our_stories_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class StoriesAdmin extends StatefulWidget {
  const StoriesAdmin({ Key? key }) : super(key: key);

  @override
  State<StoriesAdmin> createState() => _StoriesAdminState();
}

class _StoriesAdminState extends State<StoriesAdmin> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<OurStoriesViewModel>().getOurStories());
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 
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
    body:SingleChildScrollView(child: Padding(padding: kPadding / 2,
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: "Stories", size: 18.sp,weight: FontWeight.w700,),
           Padding(
              padding: const EdgeInsets.only(right:3.0, left:3),
              child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              width:size.width  / 3,
              height: 45.0,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    primary: Colors.white,
                    backgroundColor:Colors.blue,
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const NewStories())),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Icon(Icons.add, color:Colors.white),
                     const SizedBox(width:5),
                      Text("New Story",
                          style: TextStyle(
                              fontFamily: 'Core Pro',
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  ))),
            ),
        ],
      ),
       Consumer<OurStoriesViewModel>(
         builder: (context, vm, child) {
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
                      final data = vm.ourStoriesList[index];
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
                              Flexible(child: CustomText(text:data.postTitle,size:13.sp,color:kBlackColor,weight:FontWeight.w400,maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                          childCount:vm.ourStoriesList.length,
                    ),
                  ),
                ],
                 );
             }
       )
    ],),),)
    );
  }
}