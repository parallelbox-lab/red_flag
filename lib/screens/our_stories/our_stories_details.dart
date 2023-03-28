import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/our_stories_model.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class OurStoriesDetails extends StatelessWidget {
  const OurStoriesDetails({ Key? key,this.ourStoriesDetails }) : super(key: key);
  final OurStoriesModel? ourStoriesDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
        automaticallyImplyLeading: true,
        iconTheme:const IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        title: CustomText(text: "Stories",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
       actions: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Notifications.routeName),
                child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,)),
              const SizedBox(width: 20,),
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
              const SizedBox(width: 20,)
              ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Expanded(child: ),
            CustomText(text: ourStoriesDetails?.postTitle ?? ""),
            const SizedBox(height: 15),
            Visibility(
              visible:ourStoriesDetails?.postPicture == null ? false : true ,
              child:  SizedBox(
                height:30.h,
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
                imageUrl: ourStoriesDetails?.postPicture ?? "" ),
              ),),
            //Image.network(ourStoriesDetails?.postPicture ?? "", width:double.infinity, height:200),
            const SizedBox(height: 20),
            CustomText(text:ourStoriesDetails?.postDetails)
          ]),
        ),
      )
    );
  }
}