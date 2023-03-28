import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/model/questionaire_model.dart';
import 'package:red_flag/view_model/questionaire_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class QuestionaireCard extends StatefulWidget {
 const QuestionaireCard({ Key? key,this.question,required this.questionList,this.index, this.questtionLength,this.isLocked }) : super(key: key);
 final String? question; 
 final List<Answers>? questionList;
 final List<QuestionaireModel>? questtionLength;
 final int? index;
 final QuestionaireModel? isLocked;
  @override
  State<QuestionaireCard> createState() => _QuestionaireCardState();
}

class _QuestionaireCardState extends State<QuestionaireCard> {
  bool isClicked = false;
  String? question;

  @override
  Widget build(BuildContext context) {
    
    return Consumer<QuestionaireViewModel>(
      builder: (context,vm,child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: widget.question,color: Colors.white,size: 14.sp,),
        //      Container(
        //   padding: const EdgeInsets.all(10),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: widget.questionList!.map((opt) {
        //       return SizedBox(
        //         // height: 90,
        //         // margin: const EdgeInsets.only(bottom: 10),
        //         // color: Colors.black26,
        //         child: InkWell(
        //           onTap: () async {
                    // vm.selected = opt;
        //             widget.isLocked?.isLocked = true;
        //             vm.newlySelectedAns = vm.selected?.impact.toString();
        //           },
        //           child: Container(
        //             padding: const EdgeInsets.all(10),
        //             child: Row(
        //               children: [
        //                 Icon(
        //                    vm.selected == opt
        //                         ? Icons.check :  Icons.circle,
        //                     size: 25),
        //                 Expanded(
        //                   child: Container(
        //                     margin: const EdgeInsets.only(left: 16),
        //                     child: Text(
        //                       opt.description ?? "",
        //                       style: Theme.of(context).textTheme.bodyText2,
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // )
           
                    Expanded(
                      child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: widget.questionList?.length,
                          itemBuilder: (BuildContext context, index){
                          final data = widget.questionList?[index];
                          return RadioListTile(
                              title:CustomText(text: data?.description ?? "",color: Colors.white,),
                              value: data?.description ?? "", 
                              groupValue:vm.selected,                                                         
                              onChanged: (value){
                              setState(() {
                              vm.selected = value.toString();
                              widget.isLocked?.isLocked = true;
                              vm.selectedAnswer = data?.impact ?? 0;
                              debugPrint(vm.selectedAnswer.toString());
                                    // print(vm.selectedOptions);
                                  //  vm.selectedOptions.add({"index":index});    
                                  //  print(vm.selectedOptions.length);                
                                  });                      //    });
                                },
                            );
                          },
                        ),
                    ),                            
          ],
        );
      }
    );
  }
}