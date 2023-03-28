
import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/questionaire_repository.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/questionaire_model.dart';
import 'package:red_flag/screens/questionaire/widgets/questionaire_start.dart';
import 'package:red_flag/screens/questionaire/widgets/questionaire_view_result.dart';

class QuestionaireViewModel extends ChangeNotifier{
  String? _selected;
  String? get selected => _selected;
  bool _isLoading = false;
  bool get isLoading =>_isLoading;

  loading(bool? loading){
  _isLoading = loading ?? false;
  notifyListeners();
 }
 String? select;
 int selectedAnswer = 0;
 int totalCal = 0;
 int? newlySelectedAns;
 List<QuestionaireModel>? _questionaireList;
 List<QuestionaireModel> get questionaireList => _questionaireList!;

  List<int> answersScore = [];

     //map for check if the question has been answered
  double getQuesttionLen({required int currentPage}){
     final res = currentPage / questionaireList.length;         
     notifyListeners();
     return res;
  }
  QuestionaireRepositoryImpl questionaireRepositoryImpl = QuestionaireRepositoryImpl();
  set selected(String? newValue) {
    _selected = newValue;
    notifyListeners();
  }
  Future fetchQuestion({String? sectionName}) async {
     try{
      loading(true);
      _questionaireList = await questionaireRepositoryImpl.fetchQuestions(question: sectionName);
      loading(false);
     } catch(e){
      loading(false);
     // rethrow;
     }

  } 

 submitQuestionaire({ String? value}) {
  if(value == "1"){
    selectedAnswer = 2;
  }
  if(value == "-1"){
    selectedAnswer = 1;
  }

  if(value == "0"){
    selectedAnswer = 0;
  }
//  int answersIndex = 0;
//   for(var i = 0; i < answerLength!.length; i++ ){
//     answersIndex = i;
//   }
  totalCal += selectedAnswer; 
  print(totalCal);
  }

  showResult(BuildContext context,{required String currentSection}) async {
    String? rating;
    String? percentage;
    if(UserData.getPremium() == false){
    if(totalCal.clamp(1, 3) == totalCal) {
     rating = "very bad"; 
     percentage = "20";  
    } else if (totalCal.clamp(4, 5) == totalCal){
    rating = "very bad";  
    percentage ="30"; 
    } else if(totalCal.clamp(6, 8) == totalCal){
     rating ="bad";
     percentage ="40";   
    } else if(totalCal.clamp(9, 11) == totalCal){
    rating ="okay";
    percentage ="60";      
    }
    else if(totalCal.clamp(12, 13) == totalCal){
     rating = "good"; 
     percentage ="80";    
    }
    else if(totalCal == 14){
    rating = "excellent";
    percentage ="100";       
    } else {
    rating = "No Result";
    percentage ="0";    
    }
    totalCal = 0;
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> QuestionaireResult(result: rating,percentage: percentage,)));
    } else {
      if(currentSection == "SectionA") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const QuestionaireStart(currentSection: "SectionB",)));
      } else if(currentSection == "SectionB"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const QuestionaireStart(currentSection: "SectionC",)));
      } else if(currentSection == "SectionC"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const QuestionaireStart(currentSection: "SectionD",)));
      } else if (currentSection == "SectionD"){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const QuestionaireStart(currentSection: "SectionE",)));
      } else {
        if(totalCal.clamp(0, 30) == totalCal) {
        rating = "very bad";
        percentage ="30";       
        } else if (totalCal.clamp(31, 49) == totalCal){
        rating = "bad"; 
        percentage ="40";      
        } else if(totalCal.clamp(50, 69) == totalCal){
        rating ="okay";
        percentage ="60";       
        } 
        else if(totalCal.clamp(70, 90) == totalCal){
        rating = "good";  
        percentage ="70";    
        } else if(totalCal.clamp(91, 100) == totalCal){
        rating ="good"; 
        percentage ="80";     
        }
        else if(totalCal.clamp(101, 106) == totalCal){
        rating ="excellent";   
        percentage ="100";    
        } else {
        rating ="No Result";   
        percentage ="0";
        }
     totalCal = 0;
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> QuestionaireResult(result: rating,percentage: percentage,)));
      }
      
        // Navigator.pushReplacementNamed(context, QuestionaireStart.routeName, arguments: {
        //   "sectionName" : secttion
        // });
       
    }
  }

  Future calforSectionA() async{
   
    notifyListeners();
  }

 calforallSection(){
    if(totalCal.clamp(1, 3) == totalCal) {
    return "very bad";   
    } else if (totalCal.clamp(4, 5) == totalCal){
    return "very bad";   
    } else if(totalCal.clamp(6, 8) == totalCal){
     return "bad";   
    } else if(totalCal.clamp(9, 11) == totalCal){
    return "okay";   
    }
    else if(totalCal.clamp(12, 13) == totalCal){
    return "good";  
    }
    else if(totalCal == 14){
    return "excellent";   
    }
  }

  //get final score
  // double scoreResult(double value) {

  // }

}