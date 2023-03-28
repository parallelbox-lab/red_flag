
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/home/widgets/stories.dart';
import 'package:red_flag/screens/home/widgets/users_post.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/screens/search/search_page.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  ScrollController? _scrollController;
  bool? fixedScroll;
@override
  void initState() {
    _scrollController = ScrollController();
    // _scrollController?.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
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
    super.build(context); // ScreenUtil.init();
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar:AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              elevation: 3,
              centerTitle: false,
              flexibleSpace: Container(),
              title: CustomText(text: "Red Flags",color:const Color(0xff000000),size:18.sp),
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
        body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            // const SliverToBoxAdapter(child:  Padding(
            //   padding: EdgeInsets.fromLTRB(24, 35, 24, 30),
            //   child: Search(name: "Search red flag ",),
            // )),
    SliverAppBar(
      automaticallyImplyLeading: false,
    backgroundColor: kPrimaryColor,
    toolbarHeight: 110.0,
    pinned: true,
    flexibleSpace:FlexibleSpaceBar(
    centerTitle: true,
    title:Padding(
        padding:const EdgeInsets.fromLTRB(24, 0, 24, 55),
        child: SizedBox(
        height:55,
        child: TextField(
          onTap:() => Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const SearchPage())),
          readOnly:true,
          onChanged: ((value) {      
          }),
          decoration:InputDecoration(
            hintText:"Search Red Flag",
                // prefixIcon: ,
                filled: true,
                fillColor: Colors.white,
                floatingLabelStyle:const TextStyle(
                ),
              contentPadding:const EdgeInsets.only(left:18,bottom: 47 / 2),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Image.asset("assets/icons/Group 18.png"),
                  ),
              ),
                border:const OutlineInputBorder(
                  borderSide: BorderSide.none,       
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ) ,
        ),     
        ),),),
              bottom:TabBar(
                labelPadding: EdgeInsets.zero,
                controller: _tabController,
                 labelColor: const Color(0xff999999),
                labelStyle: TextStyle(fontSize: 13.sp),
                 indicatorWeight: 1, 
                unselectedLabelColor:const Color(0xff999999),
                padding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.label,
                enableFeedback: true,
                    indicatorPadding: const EdgeInsets.only(top: 33, bottom: 2),

                indicator:const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 5.0, color:Color(0xff3F37C9)),
                ),
                //isScrollable: true,
                tabs:const [
                  Tab(text: 'Home',), 
                 // SizedBox(), 
                  Tab(text: 'Stories'),
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
            controller: _tabController,
            children: const <Widget>[ 
                UsersPost(), 
                Stories()                                      
                ])
              ),
          ),
        );
  }
  @override
  bool get wantKeepAlive => true;
}