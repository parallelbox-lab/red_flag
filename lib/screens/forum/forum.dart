import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/forum/widgets/affirmations_forum.dart';
import 'package:red_flag/screens/forum/widgets/music_video_forum.dart';
import 'package:red_flag/screens/forum/widgets/riddle_forum.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:red_flag/view_model/music_view_model.dart';
import 'package:red_flag/view_model/affirmation_view_model.dart';
import 'package:red_flag/view_model/riddle_view_model.dart';
import 'package:provider/provider.dart';

class Forum extends StatefulWidget {
  const Forum({ Key? key }) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> with AutomaticKeepAliveClientMixin {

 
 @override
  void initState() {
    super.initState();
  }
  Future<void> _refreshAll(BuildContext context) async {
    await  context.read<AffirmationViewModel>().getAffirmation();
    await context.read<RiddleViewModel>().getRiddle();
    await  context.read<MusicViewModel>().getPost();  }
  @override
  Widget build(BuildContext context) {
    super.build(context); // ScreenUtil.init();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        title: CustomText(text: "Forum",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
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
    body: RefreshIndicator(
      onRefresh: (){
         return Future.delayed(const Duration(seconds: 3), () {
          _refreshAll(context);
          
        });
      },
      child: SingleChildScrollView(child: Padding(
        padding:kPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const[       
          SizedBox(height:10),
          AffirmationsForum(),
          SizedBox(height:20),
          RiddlesForum(),
          SizedBox(height:20),
          MusicVidoesForum()
        ],),
      )),
    ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}