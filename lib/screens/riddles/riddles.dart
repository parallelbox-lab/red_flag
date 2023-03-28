import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/screens/riddles/widgets/riddles_details.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/riddle_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/make_payment.dart';
import 'package:sizer/sizer.dart';

class Riddles extends StatefulWidget {
  const Riddles({ Key? key }) : super(key: key);
 static String routeName = '/riddles';
  
  @override
  State<Riddles> createState() => _RiddlesState();
}

class _RiddlesState extends State<Riddles> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<RiddleViewModel>().getRiddle());
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
     if(UserData.getPremium() == false){
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        context: context,
        enableDrag: false,
        builder: (context) => WillPopScope(
         onWillPop: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            return true;
          }, 
          child: const MakePayment()));
     }
    }); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        iconTheme:const IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        title: CustomText(text: "Riddles",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
        actions: [
        GestureDetector(
                onTap: () => Navigator.pushNamed(context, Notifications.routeName),
                child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,)),
              const SizedBox(width:10 ,),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Profile.routeName),
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                      image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(UserData.getUserProfilePic() ?? ""),
                      ),
                    ),
                    )),
              ),
              const SizedBox(width: 10,)
        ],
      ),
    body: SingleChildScrollView(child: Padding(
      padding:kPadding,
      child: Consumer<RiddleViewModel>(
                builder: (context,fetch,child) {
                if(fetch.isLoading){
                return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
                } else {         
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   // const SizedBox(height:20),   
                    CustomText(text: "All Riddles",size: 19.sp,color:const Color(0xff000000),weight: FontWeight.w600,),                  
                    const SizedBox(height:14),
                      Container(
                          padding: const EdgeInsets.only(top: 10.0),
                        //  height: 300,
                          width: MediaQuery.of(context).size.width,
                        child: GridView.builder( 
                          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 9 / 10,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                          ),    
                          shrinkWrap: true, 
                           physics:const NeverScrollableScrollPhysics(), 
                         // scrollDirection: Axis.horizontal,
                          // scrollDirection: ScrollDirection.,
                          itemCount: fetch.riddleList.length,
                          itemBuilder: (context, index) => 
                         InkWell(
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=>  RiddlesDetailsPage(riddleModel: fetch.riddleList[index],))),
                           child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, right:10),
                             child:  Container(
                                        decoration: BoxDecoration(
                                        borderRadius:const BorderRadius.all(Radius.circular(20)),
                                           color:const Color.fromARGB(100, 22, 44, 33),
                                      image:DecorationImage(
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),
                                      BlendMode.srcOver),
                                        image: NetworkImage(
                                         fetch.riddleList[index].postImage?? "",                                                  
                                        ),
                                        fit: BoxFit.cover)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [               
                                            Container(
                                              decoration: BoxDecoration(
                                              color:Colors.black.withOpacity(0.4),
                                              borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight:Radius.circular(20))),
                                              child: ListTile(
                                                title: CustomText(text:fetch.riddleList[index].question,color:Colors.white,size: 11.sp,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                            ) ]),
                          ),
                           ),
                         ),
                        //  separatorBuilder: (context, index) => CustomText(text: "See more"),
                        ),
                      ),
                    ],
                  );
                }}
              ))));
            }
          

      //  const SizedBox(height:20),
         
      //     CustomText(text: "Most Answered",size: 21.sp,color:const Color(0xff000000),maxLines: 1,),
        
      //     const SizedBox(height:10),
      //     FutureBuilder(
      //       future: Provider.of<MusicViewModel>(context,listen: false).getPost(),
      //       builder: (context,snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //         return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
      //         } else if (snapshot.hasError) {
      //           return Center(child: Text("${snapshot.error.toString()}"));
      //          } else {
      //         return Consumer<MusicViewModel>(
      //           builder: (context,fetch, child) {
      //             return Container(
      //                 padding: const EdgeInsets.only(top: 10.0),
      //                 height: 300,
      //                 width: MediaQuery.of(context).size.width,
      //               child: ListView.builder(   
      //                 scrollDirection: Axis.horizontal,
      //                 // scrollDirection: ScrollDirection.,
      //                 itemCount: fetch.musicList.length,
      //                 itemBuilder: (context, index) => 
      //                Padding(
      //                 padding: const EdgeInsets.only(right: 20.0),
      //                  child: SizedBox(
      //                   height: 250,
      //                   width: 240.0,       
      //                    child: Card(
      //                     shape: RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(15.0),
      //                      ),
      //                      child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         ClipRRect(
      //                           borderRadius:const BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15)),
      //                           child: Image.asset("assets/images/book1.png",height: 180.0, width: double.infinity, fit: BoxFit.cover)),
      //                           const SizedBox(height: 12,),
      //                           Padding(
      //                             padding: const EdgeInsets.all(9.0),
      //                             child: CustomText(text:fetch.musicList[index].title,size:15.sp,color:const Color(0xff657786),weight: FontWeight.w500,),
      //                           )               
      //                       ],
      //                      ),
      //                    ),
      //                  ),
      //                ),
      //               //  separatorBuilder: (context, index) => CustomText(text: "See more"),
      //               ),
      //             );
      //           }
      //         );
      //       }
      //  }), 
      
}