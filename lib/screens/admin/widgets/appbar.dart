import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/widgets/custom_text.dart';

appBar(){
  AppBar(
        backgroundColor: Colors.black,
        actions: [
        GestureDetector(
                // onTap: () => Navigator.pushNamed(context, Notifications.routeName),
                child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,color:Colors.white)),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomText(text: UserData.fullName()),
        )
      ]);
}