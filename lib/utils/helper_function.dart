import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  // creates conversation id for users when chatting
  static String getConvoID(String uid, String pid) {
    return uid.hashCode <= pid.hashCode ? uid + '_' + pid : pid + '_' + uid;
  }
  static getTime(String timestamp) {
    // if (dateTime.difference(DateTime.now()).inMilliseconds <= 86400000) {
    //   format = DateFormat('jm');
    // } else {
    //   format = DateFormat.yMd('en_US');
    // }
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp),isUtc: true);
  }
  static  DateTime converDate(String? date){
   var parsedDate =  getTime(date ?? "");
   String convertedDate = DateFormat("yyyy-MM-dd HH:MM").format(parsedDate);
  return DateTime.parse(convertedDate);
  }

  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
    //get formatted last active time of user in chat screen
  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);

    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  // get month name from month no. or index
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }
}