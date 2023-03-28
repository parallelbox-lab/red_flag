import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/screens/affirmations/affirmations.dart';
import 'package:red_flag/screens/affirmations/widgets/affirmation_details_page.dart';
import 'package:red_flag/view_model/affirmation_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class AffirmationSearch extends StatefulWidget {
  const AffirmationSearch({ Key? key,this.searchQuery }) : super(key: key);
  final String? searchQuery;

  @override
  State<AffirmationSearch> createState() => _AffirmationSearchState();
}

class _AffirmationSearchState extends State<AffirmationSearch> {
    @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AffirmationViewModel>().getAffirmation());
  }
  @override
  Widget build(BuildContext context) {
  return Consumer<AffirmationViewModel>(builder: (context,fetch, child) {
           if (fetch.isLoading) {
              return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
            }  else {             
              return Column(
              children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Affirmations",size: 19.sp,color:const Color(0xff000000),weight: FontWeight.w800,),  
                    ],
                  ),
                  const SizedBox(height:20),
                   widget.searchQuery!.isEmpty ?
                  const Center(child:CustomText(text: "Type a Keyword to search for Affirmation")) :
                  Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        height: 300,
                          width: MediaQuery.of(context).size.width,
                        child: ListView.builder(   
                          scrollDirection: Axis.horizontal,
                          // scrollDirection: ScrollDirection.,
                          itemCount: fetch.affirmationList.length  > 4 ? 4 : fetch.affirmationList.length,
                          itemBuilder: (context, index) { 
                         return GestureDetector(
                            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AffirmationDetialsPage(affirmationModel:fetch.affirmationList[index] ,))),
                           child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                             child: SizedBox(
                              height: 220,
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
                                      child: Image.network(fetch.affirmationList[index].postPicture ?? "",height: 180.0, width: double.infinity, fit: BoxFit.cover)),
                                      const SizedBox(height: 12,),
                                      Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: CustomText(text:fetch.affirmationList[index].title,size:15.sp,color:const Color(0xff657786),weight: FontWeight.w500,maxLines: 2,overflow:TextOverflow.ellipsis ,),
                                      )               
                                  ],
                                 ),
                               ),
                             )
                                                 ),
                         );}
                        //  separatorBuilder: (context, index) => CustomText(text: "See more"),
                        ),
                      ),
                    ],
                  );
                }            
       });
   
  }
}