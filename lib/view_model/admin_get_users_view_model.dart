import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/admin_post_repository.dart';
import 'package:red_flag/model/user_model.dart';
import 'package:red_flag/widgets/common.dart';

class AdminGetUsersViewModel extends ChangeNotifier{
  List<UserModel> _usersList =[];
  List<UserModel> get usersList => _usersList;

  AdminPostRepositoryImpl adminPostRepositoryImpl = AdminPostRepositoryImpl();

  Future<void> getUsersList() async {
    try{
     _usersList = await adminPostRepositoryImpl.userData();
    }catch(e){
      errorToast("Unable to load users list");
    }
  }
}