import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/screens/our_stories/our_stories_details.dart';
import 'package:red_flag/view_model/our_stories_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class StoriesSearch extends StatefulWidget {
  const StoriesSearch({ Key? key,this.searchQuery }) : super(key: key);
 final String? searchQuery;
  @override
  State<StoriesSearch> createState() => _StoriesSearchState();
}

class _StoriesSearchState extends State<StoriesSearch> {
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
            return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
            } else { 
            if(vm.ourStoriesList.isEmpty){
            return  const Center(child:CustomText(text: "Enter Keyword to search for stories"));
            }else { 
           
            return ListView.builder(
                    itemCount: vm.ourStoriesList.length,
                    itemBuilder:(context, index) {   
                    final data = vm.ourStoriesList[index]; 
                  if (data.postDetails
                      .toString()
                      .toLowerCase()
                      .contains(widget.searchQuery!.toLowerCase())) {           
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
                            image: NetworkImage(
                              data.postPicture ?? "",                                                  
                            ),
                            fit: BoxFit.cover
                      )
                    ),                       
                    child: Column(
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
                      // subtitle: CustomText(text: "5 mins ago",size:12.sp,color: Colors.white,),
                      trailing:GestureDetector(
                        child: Image.asset("assets/icons/iwwa_option.png",width: 35,color: Colors.white,),
                      )
                      ),
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
            }
          return Text("");
            });
          }
      }}
    );
  }
}