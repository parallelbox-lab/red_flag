import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_flag/screens/chats/chats.dart';
import 'package:red_flag/screens/forum/forum.dart';
import 'package:red_flag/screens/home/home.dart';
import 'package:red_flag/screens/questionaire/questionaire.dart';
import 'package:red_flag/screens/share_post/share_post.dart';
import 'package:sizer/sizer.dart';

class BottomNavigation extends StatefulWidget {
 const BottomNavigation(
      {Key? key, })
      : super(key: key);
  static String routeName = "/navigation";

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
     const Home(),
     const Forum(),
     const SharePost(),
     const Questionaire(),
     const Chat()
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            showUnselectedLabels: false,
            showSelectedLabels: false,
            elevation: 3,
            selectedLabelStyle:GoogleFonts.poppins(
               textStyle: TextStyle(
                fontSize: 0.0.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal)),
            unselectedLabelStyle:GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 0.0.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal)),
            onTap: _itemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding:const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:_selectedIndex == 0
                   ? const Color(0xff3F37C9) : null 
                  ),
                  child: Image.asset(
                        'assets/icons/home.png',
                        width: size.width /16,
                        height: size.height / 34,
                        color: _selectedIndex == 0
                     ? Colors.white : const Color(0xff14171A),
                      ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon:Container(
                  padding:const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:_selectedIndex == 1
                   ? const Color(0xff3F37C9) : null 
                  ),
                  child: Image.asset('assets/icons/fluent_notepad-20-regular.png',
                        color: _selectedIndex == 1
                     ? Colors.white : const Color(0xff14171A),                         
                        width: size.width /16,
                        height: size.height / 34),
                ),
                        label: ''
              ),
              BottomNavigationBarItem(
                icon:  Container(
                  padding:const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:_selectedIndex == 2
                   ? const Color(0xff3F37C9) : null 
                  ),
                  child: Image.asset('assets/icons/carbon_add-alt.png',
                          color:  _selectedIndex == 2
                   ? Colors.white :const  Color(0xff14171A),
                          width: size.width /16,
                        height: size.height / 34),
                ),
                label: ''
              ),
              BottomNavigationBarItem(
                icon:Container(
                  padding:const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:_selectedIndex == 3
                   ? const Color(0xff3F37C9) : null 
                  ),
                  child: Image.asset(
                        'assets/icons/Frame 725.png',
                        width: size.width /16,
                        height: size.height / 34,
                        color:_selectedIndex == 3
                   ? Colors.white : const Color(0xff14171A),
                      ),
                ),
                  label: ''
              ),
             BottomNavigationBarItem(
                icon:Container(
                  padding:const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:_selectedIndex == 4
                   ? const Color(0xff3F37C9) : null 
                  ),
                  child: Image.asset(
                        'assets/icons/carbon_send-alt.png',
                         width: size.width /16,
                        height: size.height / 34,
                        color: _selectedIndex == 4
                   ? Colors.white :const  Color(0xff14171A),
                      ),
                ),
                label: ''
              ),
            ],
            type: BottomNavigationBarType.fixed),
    );
  }
  
}
