import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/our_stories/our_stories_details.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/our_stories_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Stories extends StatefulWidget {
  const Stories({ Key? key }) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  void initState() {
    Future.microtask(() => context.read<OurStoriesViewModel>().getOurStories());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OurStoriesViewModel>(
      builder: (context, vm, child) { 
           if (vm.isLoading) {
             return Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
            } else {  
            return ListView.builder(
            itemCount:UserData.getPremium() != true ? vm.ourStoriesList.length  >= 10 ? 10 : vm.ourStoriesList.length : vm.ourStoriesList.length,
            itemBuilder:(context, index) {   
              final data = vm.ourStoriesList[index];  
              // final dateTime = HelperFunctions.converDate(data.postCreated.toString());          
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OurStoriesDetails(ourStoriesDetails: vm.ourStoriesList[index],))) ,
                child: Padding(
                    padding:const EdgeInsets.all(19),
                    child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19.0),
                      color:const Color.fromARGB(100, 22, 44, 33),
                          image:DecorationImage(
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6),
                          BlendMode.srcOver),
                            image: CachedNetworkImageProvider(data.postPicture ?? ""),
                            fit: BoxFit.cover
                      )
                    ),                       
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                     
                      ListTile(
                        tileColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                        // shape: ,
                        leading: Container(                              
                              padding:const EdgeInsets.only(top:10),
                              decoration: BoxDecoration(
                                // color:Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            child: Image.asset("assets/icons/Frame 718.png",width:70,height: 70,),
                  
                            ), 
                      title:CustomText(text: data.userName,size:13.sp,weight:FontWeight.w700, color: Colors.white,),
                      // subtitle: CustomText(text: data.postCreated.toString(),size:12.sp,color: Colors.white,),
                      // trailing:GestureDetector(
                      //   child: Image.asset("assets/icons/iwwa_option.png",width: 35,color: Colors.white,),
                      // )
                      ),
                       Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 25),
                            child: CustomText(text: data.postTitle, color:Colors.white, size:13.sp,maxLines: 1,overflow: TextOverflow.ellipsis,weight: FontWeight.w700,),
                      )),  
                      const Spacer(),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
                            child: CustomText(text: data.postDetails, color:Colors.white, size:13.sp,maxLines: 3,overflow: TextOverflow.ellipsis,),
                          )),                     
                      ],
                    ),
                    ),
                            ),
              );
              });
          }
      }
    );
  }
}