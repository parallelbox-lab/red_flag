import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Notifications extends StatelessWidget {
  const Notifications({ Key? key }) : super(key: key);
  static String routeName = "/notification";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme:const IconThemeData(
          color:Colors.black
        ),
        title:      
              CustomText(text: "Notifications",color: Colors.black,size:20.sp,weight: FontWeight.w600,),              
          actions: [
                   Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Profile.routeName),
                  child: Container(
                    height: 50,
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
          ],
      ),
      body: SafeArea(
        child: Center(child: CustomText(text: "Coming Soon",size:22.sp,weight: FontWeight.w800,textAlign: TextAlign.center,))
        ) ,
    // body: SafeArea(
    //   child: SingleChildScrollView(
    //     child: Padding(
    //       padding: kPadding,
    //       child: Column(
    //         children: [      
    //       // const SizedBox(height: 20,),
    //           ListView.separated(
    //             shrinkWrap: true,
    //             itemCount: 5,
    //             itemBuilder: (context, index) => Column(
    //             children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(5.0),
    //                   child: ListTile(
    //                     contentPadding: EdgeInsets.zero,
    //                     leading:Image.asset("assets/icons/Frame 718.png",width:50),
    //                     title: CustomText(text: "Emma",size:13.sp,weight: FontWeight.w600,),
    //                     subtitle:Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         CustomText(text: "liked your reply",size:11.sp,weight: FontWeight.w600,),
    //                         const SizedBox(height: 10,),
    //                         Row(
    //                                     mainAxisAlignment: MainAxisAlignment.start,
    //                                     // crossAxisAlignment: CrossAxisAlignment.start,
    //                                     children: [
    //                                       Image.asset("assets/icons/Heart.png",width:16),
    //                                       const  SizedBox(width: 15,),
    //                                       Image.asset("assets/icons/comment.png",width:16),
    //                                       const SizedBox(width: 15,),
    //                                       Image.asset("assets/icons/share.png",width:16),
    //                                     ],
    //                                   ),
    //                       ],
    //                     ),
    //                   trailing: CustomText(text: "2hrs",size:13.sp,weight: FontWeight.w500,),
    //                   ),
    //                 )
    //             ],
    //           ),
    //           separatorBuilder: (context, index) => const Divider(thickness: 2,),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    );
  }
}