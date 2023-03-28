import 'package:flutter/material.dart';
import 'package:red_flag/screens/auth/register/intro_register.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({ Key? key }) : super(key: key);
 static String routeName = "/onboarding";
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller = PageController();
  int _currentPage = 0;
  final List<Map<String, String>> _onboardingData = [
    {
      "image":"",
      "text": "You are allowed to feel messed up and inside out. It doesn't mean you're defective—it just means you're human."
    },
    {
     "image":"",
      "text": "It takes courage to grow up and become who you really are"
    },
    {
      "image":"",
      "text": "No medicine cures what happiness cannot."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          padding:const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
           image: DecorationImage(
              image: AssetImage(_currentPage == 0 ? "assets/images/onboarding screen 19.png" :
              _currentPage == 1 ? "assets/images/onboarding screen 20.png" : "assets/images/onboarding screen 21.png" ),
              fit: BoxFit.fill,
          ),
          color:const Color.fromARGB(100, 22, 44, 33),),
               child:  Column(    
          children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _onboardingData.length,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemBuilder: (context, i) {
                return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                    CustomText(text:_onboardingData[i]["text"],size:15.sp,color: Colors.white,),
                    const SizedBox(height:20),
                    CustomText(text: "– David Mitchell",size:18.sp,color:Colors.white,weight: FontWeight.w800,),
                    const SizedBox(height:30),
               
                   ],
                 );
               }
             ),
           ), 
          // const SizedBox(height: 20,), 
     Visibility(
      visible: _currentPage == 2 ?  true : false,
       child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              width: 150,
              height: 47.0,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    primary: Colors.white,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, IntroRegister.routeName , (route) => false),
                  child: Text("Get Started",
                      style: TextStyle(
                          fontFamily: 'Core Pro',
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w500,
                          color:Colors.black),
                      textAlign: TextAlign.center))),
            ],
          ),
     ),     
        const SizedBox(height: 40,), 
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              const Text(''),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    _onboardingData.length, (index) => _buildDots(index)),),
           
           _currentPage == 2 ? const Text('') : 
           GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, IntroRegister.routeName , (route) => false),
            child: const  CustomText(text: "Skip",color:Colors.white,weight: FontWeight.w700,))
             ],
           ),
            const SizedBox(height: 30,)              
          ],
        ),
    ));
  }
 _buildDots(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
          borderRadius:const BorderRadius.all(Radius.circular(50)),
          color:  _currentPage == index ? Colors.white : kSecondaryColor),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }
}