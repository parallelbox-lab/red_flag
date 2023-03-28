import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/admin_get_users_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.black,
        actions: [
        GestureDetector(
                // onTap: () => Navigator.pushNamed(context, Notifications.routeName),
         child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,color:Colors.white)),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomText(text: UserData.fullName()),
        )
      ]),
    body: SingleChildScrollView(child: Padding(
      padding:kPadding / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: "Users", size: 18.sp,weight: FontWeight.w700,),
          const SizedBox(height: 20,),
          Consumer<AdminGetUsersViewModel>(
            builder: (context,vm,child) {
              return FutureBuilder(
                future: vm.getUsersList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                  return CustomScrollView(                                     
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          slivers: <Widget>[
                          SliverToBoxAdapter(
                            // you could add any widget
                          child: ListTile(
                          // contentPadding:const EdgeInsets.all(7),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                             CustomText(text: "Name",size:14.sp,weight:FontWeight.w700),
                            //  CustomText(text: "UserName",size:14.sp,weight:FontWeight.w700),
                             CustomText(text: "Email",size:14.sp,weight:FontWeight.w700),
                             CustomText(text: "Status",size:14.sp,weight:FontWeight.w700),
                            ],
                          ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                          final data = vm.usersList[index];
                            return InkWell(
                              onTap: () {
                              
                              },
                              child: ListTile(
                              // contentPadding:const EdgeInsets.all(7),
                                //return  ListTile(
                                
                                title: Column(
                                  children: [
                                  const Divider(thickness: 2,),
                                  const SizedBox(height:10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                    Flexible(child: CustomText(text:data.fullName,size:12.sp,color:kBlackColor,weight:FontWeight.w400,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                    // Flexible(child: CustomText(text:"seun",size:13.sp,color:kBlackColor,weight:FontWeight.w400,textAlign: TextAlign.center,)),
                                    Flexible(child: CustomText(text:data.userEmail,size:12.sp,color:kBlackColor,weight:FontWeight.w400,textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                    // Flexible(child: CustomText(text:"Active",size:13.sp,color:kBlackColor,weight:FontWeight.w400,textAlign: TextAlign.center,)),
                                    const SizedBox(width: 10,),
                                    IconButton(onPressed: (){}, icon:const Icon(Icons.abc_outlined))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
            //  return   DataTable(  
            //   columns:const [  
            //     DataColumn(label: Text(  
            //         'Name',  
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
            //     )),  
            //     DataColumn(label: Text(  
            //         'Email',  
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
            //     )),  
            //     DataColumn(label: Text(  
            //         'Status',  
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)  
            //     )),  
            //   ],  
            //   rows:[  
            //     DataRow(cells: [  
            //       DataCell(Text(data.fullName ?? "")),  
            //       DataCell(Text(data.userEmail ?? "")),  
            //       DataCell(Text('Actor')),  
            //     ]),  
                             
            //     ]);
                },
                childCount:vm.usersList.length,
                    ),
                  ),
                      ],
                    );
                }
             });
            }
          )
        
      ],),
    )),
    );
  }
}