import 'package:flutter/material.dart';
import 'package:red_flag/utils/internet_utils.dart';

abstract class BaseRepository {
  Future<bool> hasInternet();

  Future<String?> getAuthToken();
}

// abstract class BaseRepositoryImpl implements BaseRepository {
//   @override
  //@protected
  // Future<bool> hasInternet() async {
  //   return await InternetUtils.isInternetAvailable();
  // }

