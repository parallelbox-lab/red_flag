import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/admin/forum_admin/widgets/affirmation_admin.dart';
import 'package:red_flag/screens/admin/forum_admin/widgets/music_video_admin.dart';
import 'package:red_flag/screens/admin/forum_admin/widgets/riddle_admin.dart';
import 'package:red_flag/widgets/custom_text.dart';


class ForumAdmin extends StatefulWidget {
  const ForumAdmin({ Key? key }) : super(key: key);

  @override
  State<ForumAdmin> createState() => _ForumAdminState();
}

class _ForumAdminState extends State<ForumAdmin> {
  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
   length: 3,
    child: Scaffold(
     appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
          GestureDetector(
                  // onTap: () => Navigator.pushNamed(context, Notifications.routeName),
                  child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,color:Colors.white)),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomText(text: UserData.fullName()),
          )
        ],
         bottom: const TabBar(
        tabs: [
          Tab(text: "Affirmation",),
          Tab(text: "Music Vidoes",),
          Tab(text: "Riddles",),
        ],
      ),
        ),
     body:const TabBarView(
      children: [
        AffirmationAdmin(),
        MusicVideoAdmin(),
        RiddleAdmin()
      ],
    ),
      ),
  );
  }
}