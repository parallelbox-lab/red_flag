
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/affirmations/widgets/affirmation_details_page.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/affirmation_view_model.dart';
import 'package:red_flag/widgets/make_payment.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/custom_text.dart';

class Affirmations extends StatefulWidget {
  const Affirmations({ Key? key, }) : super(key: key);
  // final List<AffirmationModel>? affirmationList;
  static String routeName = "/affirmations";

  @override
  State<Affirmations> createState() => _AffirmationsState();
}

class _AffirmationsState extends State<Affirmations> {
   @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AffirmationViewModel>().getAffirmation());
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
    // final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar:AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: kPrimaryColor,
              elevation: 3,
              centerTitle: false,
              iconTheme:const IconThemeData(color: Colors.black),
              flexibleSpace: Container(),
              title: CustomText(text: "Red Flags",color: Colors.black,size:18.sp),
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
        child:Padding(
          padding:const EdgeInsets.all(15),
          child: Consumer<AffirmationViewModel>(
            builder: (context,vm,child) {
              if(vm.isLoading){
                return Center(child:Platform.isAndroid ? const CircularProgressIndicator() : const CupertinoActivityIndicator());     
              } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  CustomText(text: "Affirmations",size: 21.sp,color:const Color(0xff000000)),   
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    // height: 300,
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
                    // scrollDirection: ScrollDirection.,
                    itemCount:vm.affirmationList.length,
                    itemBuilder: (context, index) => 
                    GestureDetector(
                      onTap:() => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AffirmationDetialsPage(affirmationModel:vm.affirmationList[index] ,))),
                      child: Padding(
                      padding: const EdgeInsets.only(top:10),
                        child:  Container(
                                    decoration: BoxDecoration(
                                    borderRadius:const BorderRadius.all(Radius.circular(20)),
                                       color:const Color.fromARGB(100, 22, 44, 33),
                                  image:DecorationImage(
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),
                                  BlendMode.srcOver),
                                    image: NetworkImage(
                                     vm.affirmationList[index].postPicture ?? "",                                                  
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
                                            title: CustomText(text:vm.affirmationList[index].title,color:Colors.white,size: 11.sp,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                        ) 
                ]),
                      ),
                    ),
                  //  separatorBuilder: (context, index) => CustomText(text: "See more"),                      
    )))]);
            }}
          ),
        )));
  }
}