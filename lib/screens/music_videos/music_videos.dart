import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/music_videos/widgets/music_video_details.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/music_view_model.dart';
import 'package:red_flag/widgets/make_payment.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_text.dart';

class MusicVideo extends StatefulWidget {
  const MusicVideo({ Key? key }) : super(key: key);
  static String routeName = "/music-videos";

  @override
  State<MusicVideo> createState() => _MusicVideoState();
}

class _MusicVideoState extends State<MusicVideo> {
   @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MusicViewModel>().getPost());
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
       backgroundColor: kPrimaryColor,
       appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
        iconTheme:const IconThemeData(color: Colors.black),
        elevation: 3,
        centerTitle: false,
        title: CustomText(text: "Music Videos",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
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
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<MusicViewModel>(
              builder: (context,vm,child) {
                if(vm.isLoading){
                  return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());     
                } else {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics(),
                        itemCount: vm.musicList.length,                      
                        itemBuilder: (context, index){
                          final data = vm.musicList[index];
                         return Stack(children: [
                          // Positioned(
                          //   // top: 4,
                          //   right: 4,
                          //   child: IconButton(icon: Icon(Icons.lik,size:25.sp),onPressed: (){},)),
                          GestureDetector(
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> MusicVideoDetaild(musicModel: data,))),
                           child: Container(
                                decoration: BoxDecoration(
                                borderRadius:const BorderRadius.all(Radius.circular(20)),
                                   color:const Color.fromARGB(100, 22, 44, 33),
                              image:DecorationImage(
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),
                              BlendMode.srcOver),
                                image: NetworkImage(
                                  data.postPicture ?? "",                                                  
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
                                        title: CustomText(text: data.title,color:Colors.white,size: 11.sp,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                    )                             
                                  ],
                                  
                                ),
                              ),
                          ) ],
                         );
                        }, gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 9 / 10,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                          ),
                      ),
                    );
                  }  }
            )
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 4,
            //     itemBuilder: (context, index) => Container(
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         width: 1,
            //         color: Colors.grey
            //       )
            //     ),
            //    child: CustomText(text: "All"),
            //   )),
            // ),
           
          ],
        ),
      ),    
    );
  }
}