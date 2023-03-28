import 'package:flutter/widgets.dart';
import 'package:red_flag/data/repository/sharepost_repository.dart';
import 'package:red_flag/model/post_model.dart';
import 'package:red_flag/screens/bottom_navigation.dart';
import 'package:red_flag/widgets/common.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class SharePostViewModel extends ChangeNotifier{
  final SharePostRepositoryImpl sharePostRepositoryImpl = SharePostRepositoryImpl();
  Future createPost(BuildContext context, {PostModel? sharePostModel}) async{
   bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
   try{   
    if (isConnected == true) {
     sharePostRepositoryImpl.createSharePost(sharePostModel: sharePostModel);
      showAlertDialog(context,message: "Post Created Successfully", press: ()=> Navigator.pushNamedAndRemoveUntil(context, BottomNavigation.routeName, (route) => false) );
    } else {
      showerrorDialog("No network connection 😞", context,false);
    }
    } catch (e){
      errorToast(e.toString());
    }
  }
}