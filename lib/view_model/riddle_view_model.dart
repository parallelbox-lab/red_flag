import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/riddle_repository.dart';
import 'package:red_flag/model/riddle_model.dart';
import 'package:red_flag/widgets/common.dart';

class RiddleViewModel extends ChangeNotifier{
   String? _selected;
  String? get selected => _selected;

  bool? _correctAns;
  bool? get correctAns => _correctAns;
  RiddleRepositoryImpl riddleRepositoryImpl = RiddleRepositoryImpl();
  List<RiddlesModel> _riddleList = [];
  List<RiddlesModel> get riddleList => _riddleList;
 bool _isLoading = false;
  bool get isLoading =>_isLoading;

  loading(bool? loading){
  _isLoading = loading ?? false;
  notifyListeners();
 }

 clearData(){
  _correctAns = null;
  _selected = null;
 }
 set correctAns(bool? newValue) {
    _correctAns = newValue;
    notifyListeners();
  }
 set selected(String? newValue) {
    _selected = newValue;
    notifyListeners();
  }
  Future<void> getRiddle() async {
    try{
     loading(true);
    _riddleList = await riddleRepositoryImpl.riddleCollections();
      loading(false);
    } catch(e){
      loading(false);
      errorToast("Unable to load Riddles");
    }
    // print(riddleList.map((e) => print(e.title)));
  }
}