import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/screens/questionaire/widgets/questionaire_start.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_text.dart';

class Questionaire extends StatelessWidget {
  const Questionaire({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: kPrimaryColor,
       appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        title: CustomText(text: "Questionaire",color: Colors.black,size:18.sp,weight: FontWeight.w700,),
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
      body:Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Worried-rafiki 1.png",width:size.width * 10, height: size.height / 2,),
            // const SizedBox(height:10),
            CustomText(text: "Not Feeling Well? Please Fill These Questioners",textAlign: TextAlign.center,size:14.sp),
            const SizedBox(height:20),
        Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        width: 200,
        height: 60.0,
        child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              primary: Colors.white,
              backgroundColor:const Color(0xff3F37C9),
            ),
            onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const QuestionaireStart(currentSection: "SectionA",))),
            child: Text("Start",
                style: TextStyle(
                    fontFamily: 'Core Pro',
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.w500,
                    color:Colors.white),
                textAlign: TextAlign.center))),
                const SizedBox(height: 30,),
             
          ],
      
      ),    
    );
  }
}