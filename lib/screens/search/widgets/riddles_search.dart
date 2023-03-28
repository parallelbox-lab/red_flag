import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/screens/riddles/riddles.dart';
import 'package:red_flag/screens/riddles/widgets/riddles_details.dart';
import 'package:red_flag/view_model/riddle_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class RiddlesSearch extends StatefulWidget {
  const RiddlesSearch({ Key? key,this.searchQuery}) : super(key: key);
  final String? searchQuery;
  @override
  State<RiddlesSearch> createState() => _RiddlesSearchState();
}

class _RiddlesSearchState extends State<RiddlesSearch> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<RiddleViewModel>().getRiddle());
  }
  @override
  Widget build(BuildContext context) {      
          return Consumer<RiddleViewModel>(
            builder: (context,fetch,child) {
              if(fetch.isLoading){
                return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
              } else {
              return Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Riddles",size: 19.sp,color:const Color(0xff000000),weight: FontWeight.w700,),
                  
                ],
              ),
              const SizedBox(height:10),
              widget.searchQuery!.isEmpty ?
              const Center(child:CustomText(text: "Type a Keyword to search for Riddles")) :
              Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                    child: ListView.builder(      
                      scrollDirection: Axis.horizontal,
                      // scrollDirection: ScrollDirection.,
                      itemCount: fetch.riddleList.length,
                      itemBuilder: (context, index) {
                      if (fetch.riddleList[index]
                      .toString()
                      .toLowerCase()
                      .contains(widget.searchQuery!.toLowerCase())) {    
                     return GestureDetector(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=>  RiddlesDetailsPage(riddleModel: fetch.riddleList[index],))),
                        child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                          child: SizedBox(
                          height: 230,
                          width: 220.0,       
                            child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius:const BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15)),
                                  child: SizedBox(
                                        height: 190.0, 
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => const Center(
                                            child: Text(
                                                "Unable to load image")), // This is what you need
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                        imageUrl: fetch.riddleList[index].postImage ?? "" ),
                                      )),
                                  const SizedBox(height: 12,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(text: fetch.riddleList[index].question,size:15.sp,color:const Color(0xff657786),maxLines: 2,overflow:TextOverflow.ellipsis ,),
                                  )             
                                  ],
                                 ),
                               ),
                             ),
                           ),
                         );
                        //  separatorBuilder: (context, index) => CustomText(text: "See more"),
            }
            return const Text('');
            }),
                      ),
                    ],
                  );
                }
  });
            }}
          
