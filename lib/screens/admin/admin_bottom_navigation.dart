import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_flag/screens/admin/dashboard/dashboard.dart';
import 'package:red_flag/screens/admin/forum_admin/forum_admin.dart';
import 'package:red_flag/screens/admin/stories_admin/stories_admin.dart';
import 'package:red_flag/screens/admin/users/users.dart';
import 'package:sizer/sizer.dart';

class AdminBottomNavigation extends StatefulWidget {
 const AdminBottomNavigation(
      {Key? key, })
      : super(key: key);
  static String routeName = "/navigation";

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigationState();
}

class _AdminBottomNavigationState extends State<AdminBottomNavigation> {
  late List<Widget> _pages;
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    _selectedIndex = index;
  }

  void _itemTapped(int _selectedIndex) {
    setState(
      () {
        _pageController.jumpToPage(_selectedIndex);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _pages = [
     const AdminDashboard(),
     const AllUsers(),
     const StoriesAdmin(),
     const ForumAdmin(),
    // const Chat()
    //   const Dashboard(),
    //   const AllCustomers(),
    //  const AllOrders(),
    //   const Profile()
      // const CampaignScreen(),
      // const ChallengeScreen(),
      // const CommunityScreen()
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
       bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            selectedItemColor:
               const  Color(0xff3F37C9),
            unselectedItemColor: Colors.grey,
            elevation: 3,
            selectedLabelStyle:GoogleFonts.poppins(
               textStyle: TextStyle(
                fontSize: 10.0.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal)),
            unselectedLabelStyle:GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 10.0.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal)),
            onTap: _itemTapped,
            items: [
              // BottomNavigationBarItem(
              //   icon: Image.asset(
              //         'assets/icons/Group 17.png',
              //         width: 30,
              //         height: 30,
              //         // color: _selectedIndex == 0
              //         //         ? const Color(0xff3F37C9)
              //         //         : Colors.grey
              //             // : _selectedIndex == 0
              //             //     ? Colors.black
              //             //     : lightGrey,
              //       ),
              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon:Image.asset('assets/icons/fluent_notepad-20-regular.png',
                      color: _selectedIndex == 0
                                ?const Color(0xff3F37C9)
                                : Colors.grey,                         
                        width: 30,
                        height: 30),
                        label: 'Dashboard'
              ),
             
              BottomNavigationBarItem(
                icon:Image.asset(
                      'assets/icons/Frame 725.png',
                      width: 30,
                      height: 30,
                      color: _selectedIndex == 1
                              ? const Color(0xff3F37C9)
                              : Colors.grey,
                    ),
                  label: 'Users'
              ),
             BottomNavigationBarItem(
                icon:Image.asset(
                      'assets/icons/carbon_send-alt.png',
                      width: 30,
                      height: 30,
                      color: _selectedIndex == 2
                              ? const Color(0xff3F37C9)
                              : Colors.grey,
                    ),
                label: 'Stories'
              ),
               BottomNavigationBarItem(
                icon:Image.asset(
                      'assets/icons/carbon_send-alt.png',
                      width: 30,
                      height: 30,
                      color: _selectedIndex == 3
                              ? const Color(0xff3F37C9)
                              : Colors.grey,
                    ),
                label: 'Forum'
              ),
              //  BottomNavigationBarItem(
              //   icon:Image.asset(
              //         'assets/icons/carbon_send-alt.png',
              //         width: 30,
              //         height: 30,
              //         color: _selectedIndex == 4
              //                 ? const Color(0xff3F37C9)
              //                 : Colors.grey,
              //       ),
              //   label: 'Settings'
              // ),
              
            ],
            type: BottomNavigationBarType.fixed),
    );
  }
  
}
