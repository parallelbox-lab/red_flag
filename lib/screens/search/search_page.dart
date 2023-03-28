import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/chats/widgets/chat_screen.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/our_stories/our_stories_details.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/screens/search/widgets/affirmation.dart';
import 'package:red_flag/screens/search/widgets/forum_search.dart';
import 'package:red_flag/screens/search/widgets/post.dart';
import 'package:red_flag/screens/search/widgets/stories.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/utils/helper_function.dart';
import 'package:red_flag/view_model/our_stories_view_model.dart';
import 'package:red_flag/view_model/post_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/search_form.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;
  bool? fixedScroll;
  TextEditingController searchTex = TextEditingController();
@override
  void initState() {
    _scrollController = ScrollController();
    // _scrollController?.addListener(_scrollListener);
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(_smoothScrollToTop);
    super.initState();
  }
  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }
  // _scrollListener() {
  //   if (fixedScroll!) {
  //     _scrollController?.jumpTo(0);
  //   }
  // }
  _smoothScrollToTop() {
    _scrollController?.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController?.index == 2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme:const IconThemeData(color:Colors.black),
        // automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 3,
        centerTitle: false,
        titleSpacing:3,
        title: CustomText(text: "Red Flags",color: Colors.black,size:18.sp),
        actions: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Notifications.routeName),
          child: Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,)),
        const SizedBox(width: 20,),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Profile.routeName),
          child: Image.asset("assets/icons/Frame 718.png",width: 50,)),
        const SizedBox(width: 20,)
        ],
      ),
    
        body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
              toolbarHeight: 110.0,
             pinned: true,
              flexibleSpace:FlexibleSpaceBar(
                centerTitle: true,
                title:Padding(
                  padding:const EdgeInsets.fromLTRB(24, 0, 24, 55),
                  child: Search(
                    name: "Search red flag",
                    controller: searchTex,
                    onChanged: (value){
                      setState(() {
                        searchTex.text = value;  
                      });
                    },
                  ),
                ),
              ),  
              bottom:TabBar(
                controller: _tabController,
                labelColor: const Color(0xff999999),
                labelStyle: TextStyle(fontSize: 13.sp),
                 indicatorWeight: 7, 
                 indicatorSize: TabBarIndicatorSize.label,
                 unselectedLabelColor:const Color(0xff999999),
                padding: EdgeInsets.zero,
                indicator:const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 5.0, color:Color(0xff3F37C9)),
                 // insets: EdgeInsets.symmetric(horizontal:18.0)
                ),
                // isScrollable: true,
                tabs:const [
                  Tab(text: 'Posts',),
                  Tab(text: 'Stories',),                 
                  Tab(text: 'Forum'),
                ],
              ), 
            ),
            // SliverToBoxAdapter(
            //   child: 
            // ),
          ];
        },
        body: Container(
           decoration:const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                ),
          child: TabBarView(
            key: UniqueKey(),
            controller: _tabController,
            children: [ 
            PostSearch(searchQuery: searchTex.text.trim(),),
            StoriesSearch(searchQuery:searchTex.text.trim() ,),
            ForumSearch(searchQuery:searchTex.text.trim() ,)

              // StreamBuilder(
              //   stream: (searchtxt!= "" && searchtxt!= null)?FirebaseFirestore.instance.collection("addjop").where("specilization",isNotEqualTo:searchtxt).orderBy("specilization").startAt([searchtxt,])
              //       .endAt([searchtxt+'\uf8ff',])
              //       .snapshots()
              //       :FirebaseFirestore.instance.collection("addjop").snapshots(),
              //   builder:(BuildContext context,snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting &&
              //         snapshot.hasData != true) {
              //       return Center(
              //           child:CircularProgressIndicator(),
              //       );
              //     }
              //     else
              //       {retun widget();                   
                  
                     
                ])
              ),
          ),
        );
  }
}