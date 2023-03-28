import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/model/riddle_model.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/riddle_view_model.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class RiddlesDetailsPage extends StatefulWidget {
  const RiddlesDetailsPage({ Key? key, this.riddleModel}) : super(key: key);
  final RiddlesModel? riddleModel;

  @override
  State<RiddlesDetailsPage> createState() => _RiddlesDetailsPageState();
}



class _RiddlesDetailsPageState extends State<RiddlesDetailsPage> {

  @override
  void dispose() {
    super.dispose();
   //context.read<RiddleViewModel>().clearData();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async {  
       context.read<RiddleViewModel>().correctAns = null;
      context.read<RiddleViewModel>().selected = null;
      widget.riddleModel?.isLocked = false;

          return true;
        },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title:CustomText(text: "Riddles",color: Colors.black,size: 19.sp,weight: FontWeight.w700,),
          backgroundColor: kPrimaryColor,
          iconTheme:const IconThemeData(color: Colors.black),
        ),
        body: Consumer<RiddleViewModel>(
          builder: (context, vm, child) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              //color:Colors.white,
              child: SingleChildScrollView(child: Padding(
                padding: kPadding,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                 const SizedBox(height: 34,),
                  CustomText(text: widget.riddleModel?.question ??"",size:15.sp,color:Colors.black),
                 const SizedBox(height: 20,),
               Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.riddleModel!.answers!.map((opt) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 11,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color:widget.riddleModel?.isLocked == false || widget.riddleModel?.isLocked == null ? Colors.black26 : opt.correctAns == true
                                        ?Colors.green : Colors.red,
                        border: Border.all(
                          width: 3,
                          color:vm.selected == opt.description ? Colors.blue : Colors.grey 
                        )
                      ),
                      child: InkWell(
                        onTap: () async {
                          if(widget.riddleModel?.isLocked == false || widget.riddleModel?.isLocked == null){
                            setState(() {
                
                  
                          vm.selected = opt.description;
                          vm.correctAns = opt.correctAns;
                          widget.riddleModel?.isLocked = true;
                                    });
                         // vm.newlySelectedAns = vm.selected?.impact.toString();
                        } else {
                          print(widget.riddleModel?.isLocked);
                        } },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                            //  Icon(
                                  //  vm.correctAns == true
                                  //       ? Icons.check :  ,
                            //         size: 25,color: vm.correctAns == true
                            //             ? Colors.green : Colors.red,) ,
                               Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    opt.description ?? "",
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),),
                Visibility(
                  visible: widget.riddleModel?.isLocked == false || widget.riddleModel?.isLocked == null ?false : true,
                  child: Center(child: CustomText(text:vm.correctAns == false ? "Oops you got it wrong" : "You got it right ",color:vm.correctAns == false ? Colors.red : Colors.green,textAlign: TextAlign.center,))),
                const  SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(right:15.0, left: 15),
                  child: ButtonWidget(press: (){
                    vm.selected = null;
                    vm.correctAns = null;
                    widget.riddleModel?.isLocked = false;
                    Navigator.pop(context);
                  },text: "Close",),
                )
                 ],
                  ),
                ),
              ),
            );
          }
        ),
        
      ),
    );
  }
}