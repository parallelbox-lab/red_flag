import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/screens/affirmations/affirmations.dart';
import 'package:red_flag/screens/affirmations/widgets/affirmation_details_page.dart';
import 'package:red_flag/view_model/affirmation_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class AffirmationsForum extends StatefulWidget {
  const AffirmationsForum({ Key? key }) : super(key: key);

  @override
  State<AffirmationsForum> createState() => _AffirmationsForumState();
}

class _AffirmationsForumState extends State<AffirmationsForum> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AffirmationViewModel>().getAffirmation());
  }
  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Consumer<AffirmationViewModel>(builder: (context,fetch, child) {
           if (fetch.isLoading) {
              return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
            }  else {             
              return Column(
                children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Affirmations Vidoes",size: 16.sp,color:const Color(0xff000000),weight: FontWeight.w700,),
                // InkWell(
                //   onTap: ()=> Navigator.pushNamed(context, Affirmations.routeName),
                //   child: CustomText(text: "See All", size: 14.sp,decoration: TextDecoration.underline,))
                    ],
                  ),
                    const SizedBox(height:10),
                     Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        height: size.height * 0.26,
                      //  width: MediaQuery.of(context).size.width,
                        child: fetch.affirmationList.isEmpty ?
                         const Center(child: CustomText(text: "Opps Sorry no Affirmation Added yet",),)
                         :    ListView.builder(   
                                scrollDirection: Axis.horizontal,
                                // scrollDirection: ScrollDirection.,
                                itemCount: fetch.affirmationList.length  >= 8 ? 8 : fetch.affirmationList.length,
                                itemBuilder: (context, index) { 
                                if(index == 7){
                                  return InkWell(
                                   onTap: ()=> Navigator.pushNamed(context, Affirmations.routeName),
                                    child:const Align(
                                      alignment: Alignment.center,
                                      child: CustomText(text: "Read More")),
                                  );
                                }
                                return GestureDetector(
                                 onTap:() => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AffirmationDetialsPage(affirmationModel:fetch.affirmationList[index] ,))),
                                 child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                   child: SizedBox(
                                    height: size.height * 50,
                                    width: 47.w,       
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
                                        height: size.height / 6.5, 
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
                                        imageUrl: fetch.affirmationList[index].postPicture ?? "" ),
                                      )),
                                            const SizedBox(height: 12,),
                                            Padding(
                                              padding: const EdgeInsets.all(9.0),
                                              child: CustomText(text:fetch.affirmationList[index].title,size:11.sp,color:const Color(0xff657786),maxLines: 2,overflow:TextOverflow.ellipsis ,),
                                            )               
                                        ],
                                       ),
                                     ),
                                   )),
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