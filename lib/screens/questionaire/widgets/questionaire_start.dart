import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/screens/questionaire/widgets/question_card.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/view_model/questionaire_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class QuestionaireStart extends StatefulWidget {
  const QuestionaireStart({ Key? key,this.currentSection }) : super(key: key);
  static String routeName = "/questionaire-start";
  final String? currentSection;

  @override
  State<QuestionaireStart> createState() => _QuestionaireStartState();
}

class _QuestionaireStartState extends State<QuestionaireStart> {
  int _currentPage = 0;
  double _anim = 0.0;
  final PageController _controller = PageController(initialPage: 0);
 @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<QuestionaireViewModel>().fetchQuestion(sectionName: widget.currentSection));
  }
  @override
  Widget build(BuildContext context) {
   int count = _currentPage +1;
  final size = MediaQuery.of(context).size;
    return WillPopScope(
       onWillPop: () async {  
         context.read<QuestionaireViewModel>().totalCal = 0;
         context.read<QuestionaireViewModel>().selected = null;         
          return true;
        },      
         child: Scaffold(
        body: Consumer<QuestionaireViewModel>(
                builder: (context,vm,child) {
                if(vm.isLoading){
               return Center(child:Platform.isAndroid ? const CircularProgressIndicator(): const CupertinoActivityIndicator());
          } else { 
          if(vm.questionaireList.isEmpty){
            return Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
              const Center(child: CustomText(text:"No Questionaires")),
              Center(
              child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              width: size.width * 0.4,
              height: 50.0,
              child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        primary: Colors.black
                        // backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        vm.totalCal = 0;
                        vm.selected = null;
                         Navigator.pop(context);
                      },
                      child: Text("Close",
                          style: TextStyle(
                              fontFamily: 'Core Pro',
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                              color:Colors.black),
                          textAlign: TextAlign.center)))),
                    ],
                  );
                }
                  _anim = count / vm.questionaireList.length;  
                    return Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration:const BoxDecoration(
                     // image: DecorationImage(image: Image.asset(name)),
                      color: Colors.black
                    ),
                      child:
                        // state((){
                        //   debugPrint("hr");
                        //   ;
                        //   });       
                         Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const SizedBox(height: 50,),
                        Center(
                          child: CustomText(text: "Questionaire",size:21.sp,color:Colors.white,weight: FontWeight.w800,textAlign: TextAlign.center,),
                        ),
                        const SizedBox(height: 20,),
                          Center(child: CustomText(text: widget.currentSection,size:17.sp,color:Colors.white,textAlign: TextAlign.center,)),
                        const SizedBox(height: 20,),
                         Padding(
                           padding: const EdgeInsets.only(left:17.0, right:17.0),
                           child: Row(
                             children: [
                               Expanded(
                                 child: LinearProgressIndicator(
                                  backgroundColor: const Color(0xFFE6E6EA),
                                  value:_anim,
                                  minHeight: 4,
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff3F37C9)) ),
                               ),
                              const SizedBox(width:10),
                        CustomText(text:count.toString() + '/' + vm.questionaireList.length.toString(),color: Colors.white,size: 12.sp,)
                             ],
                           ),
                         ),
                        // Center(
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       CustomText(text: (_currentPage.toString() + 1.toString())),
                        //       CustomText(text: vm.questionaireList!.length.toString())
                        //     ],
                        //   ),
                        // ),
                     Expanded(
                      child: PageView.builder(               
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _controller,
                        onPageChanged: (value) => setState(() => _currentPage = value),
                        itemCount:vm.questionaireList.length,
                        itemBuilder: (context, index) {
                          final data = vm.questionaireList[index];
                          return Padding(
                          padding:kPadding,
                          child: QuestionaireCard(                               
                            question:data.question,
                            questionList:data.answers ,
                            index: index,
                            questtionLength:vm.questionaireList,
                            isLocked:vm.questionaireList[index],
                            ),
                        );
                        }
                      ),
             ),
          const SizedBox(height: 25,),
          _currentPage + 1 != vm.questionaireList.length ?
          Column(
          children: [
         Center(
           child: Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      width: size.width * 0.4,
                      height: 50.0,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            primary: Colors.white,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                           
                          await vm.submitQuestionaire(value:vm.selectedAnswer.toString());
                          vm.selected = null;
                          _controller.nextPage(
                          duration:
                              const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                          },
                          child: Text("Next",
                              style: TextStyle(
                                  fontFamily: 'Core Pro',
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color:Colors.black),
                              textAlign: TextAlign.center))),
         ),
      const SizedBox(height: 20,),
       Center(
       child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              width: size.width * 0.4,
              height: 50.0,
              child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        primary: Colors.white,
                        // backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        vm.totalCal = 0;
                        vm.selected = null;
                         Navigator.pop(context);
                      },
                      child: Text("Close",
                          style: TextStyle(
                              fontFamily: 'Core Pro',
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                              color:Colors.white),
                          textAlign: TextAlign.center))),
       ),
       ],
     )  :
     Center(
      child:Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              width: size.width * 0.3,
              height: 50.0,
              child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        primary: Colors.white,
                        backgroundColor: Colors.white,
                      ),
                    onPressed: () {
                      vm.submitQuestionaire(value:vm.selectedAnswer.toString());
                      vm.showResult(context,currentSection: widget.currentSection ?? "");
                      vm.totalCal = 0;
                      vm.selected = null;
                    },    
                         child: Text("Submit",
                          style: TextStyle(
                              fontFamily: 'Core Pro',
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                              color:Colors.black),
                          textAlign: TextAlign.center))),),
                          const SizedBox(height: 20,),
                            ],
                        
                                      )
                        );
                      }               
      }),
            
          
        
      ),
    );
  }
}